import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Service to backup and restore entry settings when options are hidden/shown
class EntrySettingsBackupService {
  static final Map<String, BackupData> _backups = {};

  /// Backup current settings before hiding options
  static void backupSettings(String entryId, {
    required bool isCommentable,
    required bool isVotable,
    required bool inLive,
  }) {
    _backups[entryId] = BackupData(
      isCommentable: isCommentable,
      isVotable: isVotable,
      inLive: inLive,
    );
  }

  /// Restore backed up settings when options are shown again
  static BackupData? restoreSettings(String entryId) {
    return _backups[entryId];
  }

  /// Clear backup for an entry
  static void clearBackup(String entryId) {
    _backups.remove(entryId);
  }

  /// Clear all backups
  static void clearAllBackups() {
    _backups.clear();
  }
}

class BackupData {
  final bool isCommentable;
  final bool isVotable;
  final bool inLive;

  const BackupData({
    required this.isCommentable,
    required this.isVotable,
    required this.inLive,
  });
}

/// Provider for the backup service
final entrySettingsBackupServiceProvider = Provider<EntrySettingsBackupService>((ref) {
  return EntrySettingsBackupService();
});
