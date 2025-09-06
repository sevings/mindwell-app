import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/entry.dart';

class FeedSettingsSheet extends ConsumerStatefulWidget {
  final FeedSettings currentSettings;
  final Function(FeedSettings) onSettingsChanged;

  const FeedSettingsSheet({
    super.key,
    required this.currentSettings,
    required this.onSettingsChanged,
  });

  @override
  ConsumerState<FeedSettingsSheet> createState() => _FeedSettingsSheetState();
}

class _FeedSettingsSheetState extends ConsumerState<FeedSettingsSheet> {
  late FeedSettings _settings;

  @override
  void initState() {
    super.initState();
    _settings = widget.currentSettings;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 32,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          
          // Title
          Text(
            'Feed Settings',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Entries per page
          _buildEntriesPerPageSection(),
          
          const SizedBox(height: 24),
          
          // Load from
          _buildLoadFromSection(),
          
          const SizedBox(height: 24),
          
          // Display format
          _buildDisplayFormatSection(),
          
          const SizedBox(height: 24),
          
          // Sort by
          _buildSortBySection(),
          
          const SizedBox(height: 32),
          
          // Action buttons
          _buildActionButtons(),
          
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildEntriesPerPageSection() {
    final theme = Theme.of(context);
    const options = [10, 20, 30, 50, 100];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Entries per page',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: options.map((option) {
            final isSelected = _settings.entriesPerPage == option;
            return ChoiceChip(
              label: Text('$option'),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _settings = _settings.copyWith(entriesPerPage: option);
                  });
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLoadFromSection() {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Load from',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Choose what type of content to include in the feed',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        _buildLoadFromCheckbox(
          LoadSource.diaries,
          'Diaries',
          'Personal diary entries',
        ),
        _buildLoadFromCheckbox(
          LoadSource.themes,
          'Themes',
          'Themed community posts',
        ),
      ],
    );
  }

  Widget _buildLoadFromCheckbox(LoadSource source, String title, String subtitle) {
    final isSelected = _settings.loadFrom.contains(source);
    
    return CheckboxListTile(
      value: isSelected,
      onChanged: (selected) {
        setState(() {
          final newLoadFrom = Set<LoadSource>.from(_settings.loadFrom);
          if (selected == true) {
            newLoadFrom.add(source);
          } else {
            // Ensure at least one source is selected
            if (newLoadFrom.length > 1) {
              newLoadFrom.remove(source);
            }
          }
          _settings = _settings.copyWith(loadFrom: newLoadFrom);
        });
      },
      title: Text(title),
      subtitle: Text(subtitle),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildDisplayFormatSection() {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Display format',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildFormatOption(
                DisplayFormat.short,
                'Compact',
                'Grid layout with entry previews',
                Icons.grid_view,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildFormatOption(
                DisplayFormat.full,
                'Detailed',
                'Single column with full content',
                Icons.view_agenda,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormatOption(
    DisplayFormat format,
    String title,
    String subtitle,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    final isSelected = _settings.displayFormat == format;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _settings = _settings.copyWith(displayFormat: format);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outline,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? theme.colorScheme.primaryContainer.withOpacity(0.3)
              : Colors.transparent,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortBySection() {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sort by',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        _buildSortOption(SortBy.newest, 'Newest first', Icons.schedule),
        _buildSortOption(SortBy.oldest, 'Oldest first', Icons.history),
        _buildSortOption(SortBy.best, 'Most popular', Icons.trending_up),
      ],
    );
  }

  Widget _buildSortOption(SortBy sortBy, String title, IconData icon) {
    final isSelected = _settings.sortBy == sortBy;
    
    return RadioListTile<SortBy>(
      value: sortBy,
      groupValue: _settings.sortBy,
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _settings = _settings.copyWith(sortBy: value);
          });
        }
      },
      title: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Text(title),
        ],
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: FilledButton(
            onPressed: () {
              widget.onSettingsChanged(_settings);
              Navigator.of(context).pop();
            },
            child: const Text('Apply'),
          ),
        ),
      ],
    );
  }
}

// Helper function to show the settings sheet
void showFeedSettingsSheet({
  required BuildContext context,
  required FeedSettings currentSettings,
  required Function(FeedSettings) onSettingsChanged,
}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: FeedSettingsSheet(
        currentSettings: currentSettings,
        onSettingsChanged: onSettingsChanged,
      ),
    ),
  );
}