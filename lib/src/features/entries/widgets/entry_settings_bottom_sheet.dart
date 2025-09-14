import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/entry_editor_provider.dart';

/// Bottom sheet widget for configuring entry settings.
/// 
/// This widget provides controls for all entry settings including:
/// - Privacy level (Public, Friends Only, Private)
/// - Comment and vote permissions
/// - Live feed posting
/// - Sharing permissions
/// - Anonymous posting (for theme entries)
class EntrySettingsBottomSheet extends ConsumerWidget {
  /// The entry ID being edited, or null for new entries.
  final int? entryId;

  /// Whether this is for a theme entry (shows anonymous posting option).
  final bool isThemeEntry;

  const EntrySettingsBottomSheet({
    super.key,
    this.entryId,
    this.isThemeEntry = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final entryState = ref.watch(entryEditorProvider(entryId));
    
    return entryState.when(
      initial: () => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
      editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => 
        _buildSettingsSheet(context, ref, l10n, privacy, isCommentable, isVotable, inLive, isShared, isDraft),
      publishing: (isUploadingImages, uploadProgress) => const SizedBox.shrink(),
      success: (entry) => const SizedBox.shrink(),
      error: (message, canRetry) => const SizedBox.shrink(),
    );
  }

  Widget _buildSettingsSheet(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations? l10n,
    String privacy,
    bool isCommentable,
    bool isVotable,
    bool inLive,
    bool isShared,
    bool isDraft,
  ) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              l10n?.entrySettings ?? 'Entry Settings',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          const Divider(height: 1),
          
          // Privacy Level Section
          _buildPrivacySection(context, ref, l10n, privacy),
          
          // Comment and Vote Settings Section
          _buildCommentVoteSection(context, ref, l10n, isCommentable, isVotable),
          
          // Live Feed and Sharing Section
          _buildLiveFeedSharingSection(context, ref, l10n, inLive, isShared),
          
          // Anonymous Posting Section (only for theme entries)
          if (isThemeEntry) 
            _buildAnonymousSection(context, ref, l10n, isDraft),
          
          // Bottom padding for safe area
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
        ],
      ),
    );
  }

  Widget _buildPrivacySection(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations? l10n,
    String currentPrivacy,
  ) {
    return _buildSection(
      title: l10n?.privacyLevel ?? 'Privacy Level',
      children: [
        _buildPrivacyOption(
          context,
          ref,
          l10n,
          'all',
          l10n?.privacyAll ?? 'Public',
          currentPrivacy == 'all',
        ),
        _buildPrivacyOption(
          context,
          ref,
          l10n,
          'friends',
          l10n?.privacyFriends ?? 'Friends Only',
          currentPrivacy == 'friends',
        ),
        _buildPrivacyOption(
          context,
          ref,
          l10n,
          'private',
          l10n?.privacyPrivate ?? 'Private',
          currentPrivacy == 'private',
        ),
      ],
    );
  }

  Widget _buildCommentVoteSection(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations? l10n,
    bool isCommentable,
    bool isVotable,
  ) {
    return _buildSection(
      title: 'Comments & Voting',
      children: [
        _buildSwitchTile(
          context,
          ref,
          l10n,
          l10n?.allowComments ?? 'Allow Comments',
          l10n?.allowCommentsSubtitle ?? 'Let others comment on this entry',
          isCommentable,
          (value) => ref.read(entryEditorProvider(entryId).notifier).updateIsCommentable(value),
          Icons.comment_outlined,
          key: const ValueKey('allowComments'),
        ),
        _buildSwitchTile(
          context,
          ref,
          l10n,
          l10n?.allowVotes ?? 'Allow Votes',
          l10n?.allowVotesSubtitle ?? 'Let others vote on this entry',
          isVotable,
          (value) => ref.read(entryEditorProvider(entryId).notifier).updateIsVotable(value),
          Icons.how_to_vote_outlined,
          key: const ValueKey('allowVotes'),
        ),
      ],
    );
  }

  Widget _buildLiveFeedSharingSection(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations? l10n,
    bool inLive,
    bool isShared,
  ) {
    return _buildSection(
      title: 'Visibility & Sharing',
      children: [
        _buildSwitchTile(
          context,
          ref,
          l10n,
          l10n?.postInLive ?? 'Post in Live Feed',
          l10n?.postInLiveSubtitle ?? 'Show this entry in the live feed',
          inLive,
          (value) => ref.read(entryEditorProvider(entryId).notifier).updateInLive(value),
          Icons.live_tv_outlined,
          key: const ValueKey('postInLive'),
        ),
        _buildSwitchTile(
          context,
          ref,
          l10n,
          l10n?.allowSharing ?? 'Allow Sharing',
          l10n?.allowSharingSubtitle ?? 'Let others share this entry',
          isShared,
          (value) => ref.read(entryEditorProvider(entryId).notifier).updateIsShared(value),
          Icons.share_outlined,
          key: const ValueKey('allowSharing'),
        ),
      ],
    );
  }

  Widget _buildAnonymousSection(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations? l10n,
    bool isDraft,
  ) {
    return _buildSection(
      title: 'Posting Options',
      children: [
        _buildSwitchTile(
          context,
          ref,
          l10n,
          l10n?.postAnonymously ?? 'Post Anonymously',
          l10n?.postAnonymouslySubtitle ?? 'Hide your identity when posting in themes',
          isDraft,
          (value) => ref.read(entryEditorProvider(entryId).notifier).updateIsDraft(value),
          Icons.visibility_off_outlined,
          key: const ValueKey('postAnonymously'),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildPrivacyOption(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations? l10n,
    String privacyValue,
    String title,
    bool isSelected,
  ) {
    return ListTile(
      title: Text(title),
      leading: Radio<String>(
        value: privacyValue,
        groupValue: isSelected ? privacyValue : null,
        onChanged: (value) {
          if (value != null) {
            ref.read(entryEditorProvider(entryId).notifier).updatePrivacy(value);
          }
        },
      ),
      onTap: () {
        ref.read(entryEditorProvider(entryId).notifier).updatePrivacy(privacyValue);
      },
    );
  }

  Widget _buildSwitchTile(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations? l10n,
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
    IconData icon, {
    Key? key,
  }) {
    return SwitchListTile(
      key: key,
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
      value: value,
      onChanged: onChanged,
      secondary: Icon(
        icon,
        color: value ? const Color(0xFFFF5E3A) : Colors.grey,
      ),
      activeTrackColor: const Color(0xFFFF5E3A).withValues(alpha: 0.3),
      activeThumbColor: const Color(0xFFFF5E3A),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }
}

/// Shows the entry settings bottom sheet.
/// 
/// [entryId] The ID of the entry being edited, or null for new entries.
/// [isThemeEntry] Whether this is for a theme entry (shows anonymous posting option).
Future<void> showEntrySettingsBottomSheet({
  required BuildContext context,
  int? entryId,
  bool isThemeEntry = false,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: EntrySettingsBottomSheet(
        entryId: entryId,
        isThemeEntry: isThemeEntry,
      ),
    ),
  );
}
