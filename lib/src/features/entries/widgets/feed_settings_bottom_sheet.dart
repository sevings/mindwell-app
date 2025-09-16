import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/spacing.dart';
import '../models/feed_settings.dart';
import '../models/feed_type.dart';
import '../providers/entry_feed_provider.dart';

/// A bottom sheet widget for configuring feed display settings.
///
/// This widget allows users to change various [FeedSettings] options
/// such as display format, sort order, and filtering options.
/// When settings are changed, it calls [updateSettings] on the provider.
class FeedSettingsBottomSheet extends ConsumerStatefulWidget {
  /// The current feed type to update settings for
  final FeedType feedType;

  /// Optional parameter for profile/theme feeds
  final String? feedParameter;

  const FeedSettingsBottomSheet({
    super.key,
    required this.feedType,
    this.feedParameter,
  });

  @override
  ConsumerState<FeedSettingsBottomSheet> createState() =>
      _FeedSettingsBottomSheetState();
}

class _FeedSettingsBottomSheetState
    extends ConsumerState<FeedSettingsBottomSheet> {
  FeedSettings? _currentSettings;

  @override
  void initState() {
    super.initState();
    // Initialize with null - will be set in build method
    _currentSettings = null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    // Get current settings from the provider state
    final feedState = ref.watch(
      entryFeedProvider((
        feedType: widget.feedType,
        feedParameter: widget.feedParameter,
      )),
    );
    final settings = feedState.when(
      initial: () => FeedSettings.defaultSettings,
      loading: () => FeedSettings.defaultSettings,
      loaded: (entries, hasMore, settings) => settings,
      error: (message, entries) => FeedSettings.defaultSettings,
      empty: () => FeedSettings.defaultSettings,
    );

    // Initialize current settings if not set
    _currentSettings ??= settings;

    return Container(
      padding: const EdgeInsets.all(MindwellSpacing.lg),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n?.settings ?? 'Settings',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),

            const SizedBox(height: MindwellSpacing.md),

            // Display Format Section
            Text(
              l10n?.displayFormat ?? 'Display Format',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: MindwellSpacing.sm),
            _buildDisplayFormatSelector(),

            const SizedBox(height: MindwellSpacing.lg),

            // Sort Order Section (only for profile feed)
            if (_shouldShowSortOrder()) ...[
              Text(
                l10n?.sortOrder ?? 'Sort Order',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: MindwellSpacing.sm),
              _buildSortOrderSelector(),

              const SizedBox(height: MindwellSpacing.lg),
            ],

            // Source Options Section (only for live and best feeds)
            if (_shouldShowSourceOptions()) ...[
              Text(
                l10n?.sourceOptions ?? 'Source Options',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: MindwellSpacing.sm),
              _buildSourceOptions(),

              const SizedBox(height: MindwellSpacing.lg),
            ],

            // Entry Count Section (only for best feed)
            if (_shouldShowEntryCount()) ...[
              Text(
                l10n?.entryCount ?? 'Entry Count',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: MindwellSpacing.sm),
              _buildEntryCountSelector(),

              const SizedBox(height: MindwellSpacing.lg),
            ],

            // Apply Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _applySettings,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF5E3A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: MindwellSpacing.md,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  l10n?.applySettings ?? 'Apply Settings',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // Add bottom padding for safe area
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplayFormatSelector() {
    final l10n = AppLocalizations.of(context);

    return Row(
      children: [
        Expanded(
          child: _buildFormatOption(
            DisplayFormat.short,
            l10n?.short ?? 'Short',
            Icons.view_module,
          ),
        ),
        const SizedBox(width: MindwellSpacing.sm),
        Expanded(
          child: _buildFormatOption(
            DisplayFormat.full,
            l10n?.full ?? 'Full',
            Icons.view_list,
          ),
        ),
      ],
    );
  }

  Widget _buildFormatOption(DisplayFormat format, String label, IconData icon) {
    final isSelected = _currentSettings?.displayFormat == format;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentSettings = _currentSettings?.copyWith(displayFormat: format);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(MindwellSpacing.md),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFF5E3A).withValues(alpha: 0.1)
              : Colors.grey.withValues(alpha: 0.1),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFF5E3A)
                : Colors.grey.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFFFF5E3A) : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: MindwellSpacing.sm),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFFFF5E3A) : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOrderSelector() {
    final l10n = AppLocalizations.of(context);

    return Column(
      children: [
        _buildSortOption(SortOrder.newest, l10n?.newestFirst ?? 'Newest First'),
        const SizedBox(height: MindwellSpacing.sm),
        _buildSortOption(SortOrder.oldest, l10n?.oldestFirst ?? 'Oldest First'),
        const SizedBox(height: MindwellSpacing.sm),
        _buildSortOption(SortOrder.best, l10n?.bestFirst ?? 'Best First'),
      ],
    );
  }

  Widget _buildSortOption(SortOrder order, String label) {
    final isSelected = _currentSettings?.sortOrder == order;

    return ListTile(
      title: Text(label),
      leading: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? const Color(0xFFFF5E3A) : Colors.grey,
            width: 2,
          ),
          color: isSelected ? const Color(0xFFFF5E3A) : Colors.transparent,
        ),
        child: isSelected
            ? const Icon(Icons.circle, size: 8, color: Colors.white)
            : null,
      ),
      onTap: () {
        setState(() {
          _currentSettings = _currentSettings?.copyWith(sortOrder: order);
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  /// Check if sort order should be shown for the current feed type
  bool _shouldShowSortOrder() {
    return widget.feedType == FeedType.profile;
  }

  /// Check if source options should be shown for the current feed type
  bool _shouldShowSourceOptions() {
    return widget.feedType == FeedType.live || widget.feedType == FeedType.best;
  }

  /// Check if entry count should be shown for the current feed type
  bool _shouldShowEntryCount() {
    return widget.feedType == FeedType.best;
  }

  Widget _buildSourceOptions() {
    final l10n = AppLocalizations.of(context);

    return Column(
      children: [
        SwitchListTile(
          title: Text(l10n?.includeTlogs ?? 'Include Tlogs'),
          subtitle: Text(
            l10n?.includeTlogsSubtitle ?? 'Show entries from diaries',
          ),
          value: _currentSettings?.includeTlogs ?? true,
          onChanged: (value) {
            setState(() {
              _currentSettings = _currentSettings?.copyWithValidated(
                includeTlogs: value,
              );
            });
          },
          activeThumbColor: const Color(0xFFFF5E3A),
        ),
        SwitchListTile(
          title: Text(l10n?.includeThemes ?? 'Include Themes'),
          subtitle: Text(
            l10n?.includeThemesSubtitle ?? 'Show entries from themes',
          ),
          value: _currentSettings?.includeThemes ?? true,
          onChanged: (value) {
            setState(() {
              _currentSettings = _currentSettings?.copyWithValidated(
                includeThemes: value,
              );
            });
          },
          activeThumbColor: const Color(0xFFFF5E3A),
        ),
      ],
    );
  }

  Widget _buildEntryCountSelector() {
    final l10n = AppLocalizations.of(context);

    // Specific entry count options: 10, 20, 30, 50, 100
    final entryCountOptions = [10, 20, 30, 50, 100];

    return Container(
      padding: const EdgeInsets.all(MindwellSpacing.md),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n?.entryCountSubtitle ?? 'Number of entries to display per page',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: MindwellSpacing.sm),
          DropdownButton<int>(
            value: _currentSettings?.entriesPerPage ?? 20,
            isExpanded: true,
            items: entryCountOptions.map((count) {
              return DropdownMenuItem<int>(
                value: count,
                child: Text(_getEntryCountText(count, l10n)),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _currentSettings = _currentSettings?.copyWith(
                    entriesPerPage: value,
                  );
                });
              }
            },
            style: const TextStyle(fontSize: 16, color: Colors.black87),
            dropdownColor: Colors.white,
            icon: const Icon(Icons.arrow_drop_down, color: Color(0xFFFF5E3A)),
            underline: Container(height: 1, color: const Color(0xFFFF5E3A)),
          ),
        ],
      ),
    );
  }

  /// Get localized text for entry count options
  String _getEntryCountText(int count, AppLocalizations? l10n) {
    switch (count) {
      case 10:
        return l10n?.entriesCount10 ?? '10 entries';
      case 20:
        return l10n?.entriesCount20 ?? '20 entries';
      case 30:
        return l10n?.entriesCount30 ?? '30 entries';
      case 50:
        return l10n?.entriesCount50 ?? '50 entries';
      case 100:
        return l10n?.entriesCount100 ?? '100 entries';
      default:
        return '$count entries';
    }
  }

  void _applySettings() {
    // Update the provider with new settings
    if (_currentSettings != null) {
      ref
          .read(
            entryFeedProvider((
              feedType: widget.feedType,
              feedParameter: widget.feedParameter,
            )).notifier,
          )
          .updateSettings(_currentSettings!);
    }

    // Close the bottom sheet
    Navigator.of(context).pop();
  }
}
