import 'package:hive/hive.dart';
import 'package:mindwell_api/mindwell_api.dart';

part 'cached_message.g.dart';

/// Hive model for caching chat messages locally
@HiveType(typeId: 0)
class CachedMessage extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? chatId;

  @HiveField(2)
  String? authorName;

  @HiveField(3)
  double? createdAt;

  @HiveField(4)
  bool read;

  @HiveField(5)
  String? content;

  @HiveField(6)
  String? editContent;

  @HiveField(7)
  String? rightsJson;

  @HiveField(8)
  String chatUsername;

  @HiveField(9)
  DateTime cachedAt;

  CachedMessage({
    this.id,
    this.chatId,
    this.authorName,
    this.createdAt,
    this.read = false,
    this.content,
    this.editContent,
    this.rightsJson,
    required this.chatUsername,
    required this.cachedAt,
  });

  /// Convert from MwMessage to CachedMessage
  factory CachedMessage.fromMwMessage(MwMessage message, String chatUsername) {
    return CachedMessage(
      id: message.id,
      chatId: message.chatId,
      authorName: message.author?.name,
      createdAt: message.createdAt,
      read: message.read ?? false,
      content: message.content,
      editContent: message.editContent,
      rightsJson: message.rights?.toString(),
      chatUsername: chatUsername,
      cachedAt: DateTime.now(),
    );
  }

  /// Convert to MwMessage
  MwMessage toMwMessage() {
    return MwMessage(
      (b) => b
        ..id = id
        ..chatId = chatId
        ..author = authorName != null
            ? $MwFriend((b) => b..name = authorName)
            : null
        ..createdAt = createdAt
        ..read = read
        ..content = content
        ..editContent = editContent
        ..rights = null, // We'll leave rights as null for now
    );
  }
}
