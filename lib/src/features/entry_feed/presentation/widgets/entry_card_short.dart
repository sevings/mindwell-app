import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/entry.dart';

class EntryCardShort extends StatelessWidget {
  final Entry entry;
  final VoidCallback? onTap;
  final VoidCallback? onAuthorTap;
  final VoidCallback? onVote;
  final VoidCallback? onBookmark;

  const EntryCardShort({
    super.key,
    required this.entry,
    this.onTap,
    this.onAuthorTap,
    this.onVote,
    this.onBookmark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Card(
      margin: const EdgeInsets.all(4.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image (if available)
            if (entry.imageUrl != null) _buildImage(),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    entry.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Content preview
                  Text(
                    _getContentPreview(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Author and metadata
                  _buildAuthorRow(context),
                  
                  const SizedBox(height: 8),
                  
                  // Action buttons
                  _buildActionButtons(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: CachedNetworkImage(
        imageUrl: entry.imageUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: Icon(
            Icons.broken_image,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildAuthorRow(BuildContext context) {
    return GestureDetector(
      onTap: onAuthorTap,
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 12,
            backgroundImage: entry.author.avatarUrl != null
                ? CachedNetworkImageProvider(entry.author.avatarUrl!)
                : null,
            child: entry.author.avatarUrl == null
                ? Text(
                    entry.author.showName.isNotEmpty
                        ? entry.author.showName[0].toUpperCase()
                        : '?',
                    style: const TextStyle(fontSize: 12),
                  )
                : null,
          ),
          
          const SizedBox(width: 8),
          
          // Author name and date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.author.showName,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  _formatDate(entry.createdAt),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          
          // Online indicator
          if (entry.author.isOnline == true)
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        // Vote button
        _ActionButton(
          icon: entry.isVoted ? Icons.favorite : Icons.favorite_border,
          count: entry.votesCount,
          isActive: entry.isVoted,
          onTap: onVote,
          color: entry.isVoted ? Colors.red : null,
        ),
        
        const SizedBox(width: 16),
        
        // Comments button
        _ActionButton(
          icon: Icons.chat_bubble_outline,
          count: entry.commentsCount,
          isActive: false,
          onTap: onTap, // Same as card tap - goes to detail
        ),
        
        const Spacer(),
        
        // Bookmark button
        IconButton(
          icon: Icon(
            entry.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            size: 20,
          ),
          color: entry.isBookmarked 
              ? Theme.of(context).colorScheme.primary 
              : Theme.of(context).colorScheme.onSurfaceVariant,
          onPressed: onBookmark,
          constraints: const BoxConstraints(
            minWidth: 32,
            minHeight: 32,
          ),
          padding: const EdgeInsets.all(4),
        ),
      ],
    );
  }

  String _getContentPreview() {
    // Remove HTML tags and get plain text preview
    String content = entry.content
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    
    // Apply cut position if available
    if (entry.cutPos != null && entry.cutPos! > 0 && entry.cutPos! < content.length) {
      content = content.substring(0, entry.cutPos!);
    }
    
    return content;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat.yMMMd().format(date);
    }
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final int count;
  final bool isActive;
  final VoidCallback? onTap;
  final Color? color;

  const _ActionButton({
    required this.icon,
    required this.count,
    required this.isActive,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? 
        (isActive 
            ? theme.colorScheme.primary 
            : theme.colorScheme.onSurfaceVariant);
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: effectiveColor,
            ),
            if (count > 0) ...[
              const SizedBox(width: 4),
              Text(
                _formatCount(count),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: effectiveColor,
                  fontWeight: isActive ? FontWeight.w600 : null,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatCount(int count) {
    if (count < 1000) {
      return count.toString();
    } else if (count < 1000000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    }
  }
}