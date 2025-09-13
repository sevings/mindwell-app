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
  ConsumerState<FeedSettingsBottomSheet> createState() => _FeedSettingsBottomSheetState();
}

class _FeedSettingsBottomSheetState extends ConsumerState<FeedSettingsBottomSheet> {
  late FeedSettings _currentSettings;

  @override
  void initState() {
    super.initState();
    // Get current settings from the provider
    final feedState = ref.read(entryFeedProvider(widget.feedType));
    _currentSettings = feedState.when(
      initial: () => FeedSettings.defaultSettings,
      loading: () => FeedSettings.defaultSettings,
      loaded: (entries, hasMore, settings) => settings,
      error: (message, entries) => FeedSettings.defaultSettings,
      empty: () => FeedSettings.defaultSettings,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
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
            'Display Format',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: MindwellSpacing.sm),
          _buildDisplayFormatSelector(),
          
          const SizedBox(height: MindwellSpacing.lg),
          
          // Sort Order Section
          Text(
            'Sort Order',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: MindwellSpacing.sm),
          _buildSortOrderSelector(),
          
          const SizedBox(height: MindwellSpacing.lg),
          
          // Filter Options Section
          Text(
            'Filter Options',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: MindwellSpacing.sm),
          _buildFilterOptions(),
          
          const SizedBox(height: MindwellSpacing.lg),
          
          // Auto-refresh Section
          Text(
            'Auto-refresh',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: MindwellSpacing.sm),
          _buildAutoRefreshOptions(),
          
          const SizedBox(height: MindwellSpacing.lg),
          
          // Apply Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _applySettings,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5E3A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: MindwellSpacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Apply Settings',
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
    return Row(
      children: [
        Expanded(
          child: _buildFormatOption(
            DisplayFormat.short,
            'Short',
            Icons.view_module,
          ),
        ),
        const SizedBox(width: MindwellSpacing.sm),
        Expanded(
          child: _buildFormatOption(
            DisplayFormat.full,
            'Full',
            Icons.view_list,
          ),
        ),
      ],
    );
  }

  Widget _buildFormatOption(DisplayFormat format, String label, IconData icon) {
    final isSelected = _currentSettings.displayFormat == format;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentSettings = _currentSettings.copyWith(displayFormat: format);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(MindwellSpacing.md),
        decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFF5E3A).withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
        border: Border.all(
          color: isSelected ? const Color(0xFFFF5E3A) : Colors.grey.withValues(alpha: 0.3),
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
    return Column(
      children: [
        _buildSortOption(SortOrder.newest, 'Newest First'),
        const SizedBox(height: MindwellSpacing.sm),
        _buildSortOption(SortOrder.oldest, 'Oldest First'),
        const SizedBox(height: MindwellSpacing.sm),
        _buildSortOption(SortOrder.best, 'Best First'),
      ],
    );
  }

  Widget _buildSortOption(SortOrder order, String label) {
    final isSelected = _currentSettings.sortOrder == order;
    
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
            ? const Icon(
                Icons.circle,
                size: 8,
                color: Colors.white,
              )
            : null,
      ),
      onTap: () {
        setState(() {
          _currentSettings = _currentSettings.copyWith(sortOrder: order);
        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildFilterOptions() {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('Images Only'),
          subtitle: const Text('Show only entries with images'),
          value: _currentSettings.imagesOnly,
          onChanged: (value) {
            setState(() {
              _currentSettings = _currentSettings.copyWith(imagesOnly: value);
            });
          },
          activeThumbColor: const Color(0xFFFF5E3A),
        ),
        SwitchListTile(
          title: const Text('Favorites Only'),
          subtitle: const Text('Show only favorited entries'),
          value: _currentSettings.favoritesOnly,
          onChanged: (value) {
            setState(() {
              _currentSettings = _currentSettings.copyWith(favoritesOnly: value);
            });
          },
          activeThumbColor: const Color(0xFFFF5E3A),
        ),
        SwitchListTile(
          title: const Text('Followed Only'),
          subtitle: const Text('Show only entries from followed users'),
          value: _currentSettings.followedOnly,
          onChanged: (value) {
            setState(() {
              _currentSettings = _currentSettings.copyWith(followedOnly: value);
            });
          },
          activeThumbColor: const Color(0xFFFF5E3A),
        ),
      ],
    );
  }

  Widget _buildAutoRefreshOptions() {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('Enable Auto-refresh'),
          subtitle: const Text('Automatically refresh the feed'),
          value: _currentSettings.autoRefresh,
          onChanged: (value) {
            setState(() {
              _currentSettings = _currentSettings.copyWith(autoRefresh: value);
            });
          },
          activeThumbColor: const Color(0xFFFF5E3A),
        ),
        if (_currentSettings.autoRefresh) ...[
          const SizedBox(height: MindwellSpacing.sm),
          ListTile(
            title: const Text('Refresh Interval'),
            subtitle: Text('${_currentSettings.autoRefreshInterval} seconds'),
            trailing: DropdownButton<int>(
              value: _currentSettings.autoRefreshInterval,
              items: const [
                DropdownMenuItem(value: 15, child: Text('15 seconds')),
                DropdownMenuItem(value: 30, child: Text('30 seconds')),
                DropdownMenuItem(value: 60, child: Text('1 minute')),
                DropdownMenuItem(value: 120, child: Text('2 minutes')),
                DropdownMenuItem(value: 300, child: Text('5 minutes')),
              ],
              onChanged: (value) {
                setState(() {
                  _currentSettings = _currentSettings.copyWith(autoRefreshInterval: value!);
                });
              },
            ),
          ),
        ],
      ],
    );
  }

  void _applySettings() {
    // Update the provider with new settings
    ref.read(entryFeedProvider(widget.feedType).notifier)
        .updateSettings(_currentSettings);
    
    // Close the bottom sheet
    Navigator.of(context).pop();
  }
}
