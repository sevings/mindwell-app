import 'package:flutter_quill/flutter_quill.dart';
import 'package:dart_quill_delta/dart_quill_delta.dart';

/// Utility class for converting Quill Delta to Markdown format.
/// 
/// This converter handles the following markdown elements:
/// - Headings (H3, H4, H5, H6)
/// - Bold, italic, strikethrough text
/// - Code blocks and inline code
/// - Ordered and unordered lists
/// - Blockquotes
/// - Links
class MarkdownConverter {
  /// Convert a Quill Document to Markdown string
  static String documentToMarkdown(Document document) {
    final buffer = StringBuffer();
    final operations = document.toDelta().toList();
    
    for (int i = 0; i < operations.length; i++) {
      final operation = operations[i];
      final nextOperation = i + 1 < operations.length ? operations[i + 1] : null;
      
      _processOperation(operation, nextOperation, buffer);
    }
    
    return buffer.toString().trim();
  }

  /// Process a single Delta operation and append to buffer
  static void _processOperation(
    Operation operation,
    Operation? nextOperation,
    StringBuffer buffer,
  ) {
    if (operation.data is String) {
      final text = operation.data as String;
      final attributes = operation.attributes ?? <String, dynamic>{};
      
      // Handle line breaks
      if (text == '\n') {
        _handleLineBreak(attributes, buffer);
        return;
      }
      
      // Apply formatting to text
      final formattedText = _applyFormatting(text, attributes);
      buffer.write(formattedText);
    } else if (operation.data is Map<String, dynamic>) {
      // Handle embeds (images, etc.)
      final embed = operation.data as Map<String, dynamic>;
      if (embed['image'] != null) {
        buffer.write('![Image](${embed['image']})');
      }
    }
  }

  /// Handle line breaks and block-level elements
  static void _handleLineBreak(
    Map<String, dynamic> attributes,
    StringBuffer buffer,
  ) {
    // Check for block-level elements
    if (attributes.containsKey(Attribute.h3.key)) {
      buffer.write('\n### ');
    } else if (attributes.containsKey(Attribute.h4.key)) {
      buffer.write('\n#### ');
    } else if (attributes.containsKey(Attribute.h5.key)) {
      buffer.write('\n##### ');
    } else if (attributes.containsKey(Attribute.h6.key)) {
      buffer.write('\n###### ');
    } else if (attributes.containsKey(Attribute.blockQuote.key)) {
      buffer.write('\n> ');
    } else if (attributes.containsKey(Attribute.ul.key)) {
      buffer.write('\n- ');
    } else if (attributes.containsKey(Attribute.ol.key)) {
      buffer.write('\n1. ');
    } else if (attributes.containsKey(Attribute.codeBlock.key)) {
      buffer.write('\n```\n');
    } else {
      buffer.write('\n');
    }
  }

  /// Apply inline formatting to text
  static String _applyFormatting(String text, Map<String, dynamic> attributes) {
    String result = text;
    
    // Apply formatting in reverse order of precedence
    if (attributes.containsKey(Attribute.link.key)) {
      final link = attributes[Attribute.link.key];
      if (link is LinkAttribute) {
        result = '[$result](${link.value})';
      }
    }
    
    if (attributes.containsKey(Attribute.inlineCode.key)) {
      result = '`$result`';
    }
    
    if (attributes.containsKey(Attribute.strikeThrough.key)) {
      result = '~~$result~~';
    }
    
    if (attributes.containsKey(Attribute.italic.key)) {
      result = '*$result*';
    }
    
    if (attributes.containsKey(Attribute.bold.key)) {
      result = '**$result**';
    }
    
    return result;
  }

  /// Convert a Quill Delta to Markdown string
  static String deltaToMarkdown(Delta delta) {
    final document = Document.fromDelta(delta);
    return documentToMarkdown(document);
  }

  /// Convert plain text to a basic Quill Document
  static Document plainTextToDocument(String text) {
    final delta = Delta()..insert(text);
    return Document.fromDelta(delta);
  }

  /// Convert markdown string to Quill Document
  /// 
  /// This is a basic implementation that handles common markdown elements.
  /// For more complex markdown parsing, consider using a dedicated markdown parser.
  static Document markdownToDocument(String markdown) {
    final lines = markdown.split('\n');
    final delta = Delta();
    
    for (final line in lines) {
      final trimmedLine = line.trim();
      
      if (trimmedLine.isEmpty) {
        delta.insert('\n');
        continue;
      }
      
      // Handle headings
      if (trimmedLine.startsWith('### ')) {
        delta.insert(trimmedLine.substring(4), Attribute.h3.toJson());
      } else if (trimmedLine.startsWith('#### ')) {
        delta.insert(trimmedLine.substring(5), Attribute.h4.toJson());
      } else if (trimmedLine.startsWith('##### ')) {
        delta.insert(trimmedLine.substring(6), Attribute.h5.toJson());
      } else if (trimmedLine.startsWith('###### ')) {
        delta.insert(trimmedLine.substring(7), Attribute.h6.toJson());
      }
      // Handle blockquotes
      else if (trimmedLine.startsWith('> ')) {
        delta.insert(trimmedLine.substring(2), Attribute.blockQuote.toJson());
      }
      // Handle unordered lists
      else if (trimmedLine.startsWith('- ')) {
        delta.insert(trimmedLine.substring(2), Attribute.ul.toJson());
      }
      // Handle ordered lists
      else if (RegExp(r'^\d+\. ').hasMatch(trimmedLine)) {
        final match = RegExp(r'^\d+\. (.+)$').firstMatch(trimmedLine);
        if (match != null) {
          delta.insert(match.group(1)!, Attribute.ol.toJson());
        }
      }
      // Handle code blocks
      else if (trimmedLine.startsWith('```')) {
        delta.insert(trimmedLine, Attribute.codeBlock.toJson());
      }
      // Handle regular text with inline formatting
      else {
        delta.insert(_parseInlineFormatting(trimmedLine));
      }
      
      delta.insert('\n');
    }
    
    return Document.fromDelta(delta);
  }

  /// Parse inline formatting in a line of text
  static Delta _parseInlineFormatting(String text) {
    final delta = Delta();
    final buffer = StringBuffer();
    bool inBold = false;
    bool inItalic = false;
    bool inStrikethrough = false;
    bool inCode = false;
    bool inLink = false;
    
    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      
      // Handle bold (**text**)
      if (char == '*' && i + 1 < text.length && text[i + 1] == '*') {
        if (inBold) {
          delta.insert(buffer.toString(), Attribute.bold.toJson());
          buffer.clear();
          inBold = false;
        } else {
          delta.insert(buffer.toString());
          buffer.clear();
          inBold = true;
        }
        i++; // Skip next asterisk
        continue;
      }
      
      // Handle italic (*text*)
      if (char == '*' && !inBold) {
        if (inItalic) {
          delta.insert(buffer.toString(), Attribute.italic.toJson());
          buffer.clear();
          inItalic = false;
        } else {
          delta.insert(buffer.toString());
          buffer.clear();
          inItalic = true;
        }
        continue;
      }
      
      // Handle strikethrough (~~text~~)
      if (char == '~' && i + 1 < text.length && text[i + 1] == '~') {
        if (inStrikethrough) {
          delta.insert(buffer.toString(), Attribute.strikeThrough.toJson());
          buffer.clear();
          inStrikethrough = false;
        } else {
          delta.insert(buffer.toString());
          buffer.clear();
          inStrikethrough = true;
        }
        i++; // Skip next tilde
        continue;
      }
      
      // Handle inline code (`text`)
      if (char == '`') {
        if (inCode) {
          delta.insert(buffer.toString(), Attribute.inlineCode.toJson());
          buffer.clear();
          inCode = false;
        } else {
          delta.insert(buffer.toString());
          buffer.clear();
          inCode = true;
        }
        continue;
      }
      
      // Handle links ([text](url))
      if (char == '[' && !inLink) {
        delta.insert(buffer.toString());
        buffer.clear();
        inLink = true;
        continue;
      }
      
      if (char == ']' && inLink && i + 1 < text.length && text[i + 1] == '(') {
        final linkText = buffer.toString();
        buffer.clear();
        i += 2; // Skip ']('
        
        // Find closing parenthesis
        final urlStart = i;
        while (i < text.length && text[i] != ')') {
          i++;
        }
        
        if (i < text.length) {
          final url = text.substring(urlStart, i);
          delta.insert(linkText, LinkAttribute(url).toJson());
          buffer.clear();
          inLink = false;
          continue;
        }
      }
      
      buffer.write(char);
    }
    
    // Add remaining text
    if (buffer.isNotEmpty) {
      delta.insert(buffer.toString());
    }
    
    return delta;
  }
}
