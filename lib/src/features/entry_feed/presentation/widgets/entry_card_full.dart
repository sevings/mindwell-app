import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/entry.dart';

class EntryCardFull extends StatelessWidget {
  final Entry entry;
  final VoidCallback? onTap;
  final VoidCallback? onAuthorTap;
  final VoidCallback? onVote;
  final VoidCallback? onBookmark;

  const EntryCardFull({
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
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildAuthorHeader(context),
            ),
            
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                entry.title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Image (if available)
            if (entry.imageUrl != null) _buildImage(context),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Content preview
                  Text(
                    _getContentPreview(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Tags
                  if (entry.tags != null && entry.tags!.isNotEmpty)
                    _buildTagsRow(context),
                  
                  if (entry.tags != null && entry.tags!.isNotEmpty)
                    const SizedBox(height: 16),
                  
                  // Action buttons and metadata
                  _buildActionRow(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthorHeader(BuildContext context) {
    return GestureDetector(
      onTap: onAuthorTap,
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundImage: entry.author.avatarUrl != null
                ? CachedNetworkImageProvider(entry.author.avatarUrl!)
                : null,
            child: entry.author.avatarUrl == null
                ? Text(
                    entry.author.showName.isNotEmpty
                        ? entry.author.showName[0].toUpperCase()
                        : '?',
                    style: const TextStyle(fontSize: 16),
                  )
                : null,
          ),
          
          const SizedBox(width: 12),
          
          // Author info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      entry.author.showName,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                    const SizedBox(width: 8),
                    
                    // Online indicator
                    if (entry.author.isOnline == true)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                
                const SizedBox(height: 2),
                
                Text(
                  '@${entry.author.name}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          
          // Date
          Text(
            _formatDate(entry.createdAt),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: AspectRatio(
          aspectRatio: 16 / 10,
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
                size: 48,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTagsRow(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: entry.tags!.take(5).map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            '#$tag',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionRow(BuildContext context) {
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
        
        const SizedBox(width: 24),
        
        // Comments button
        _ActionButton(
          icon: Icons.chat_bubble_outline,
          count: entry.commentsCount,
          isActive: false,
          onTap: onTap, // Same as card tap - goes to detail
        ),
        
        const SizedBox(width: 24),
        
        // Watch button (if available)
        if (entry.canVote == true && entry.isWatching != null)
          _ActionButton(
            icon: entry.isWatching! ? Icons.visibility : Icons.visibility_outlined,
            count: 0,
            isActive: entry.isWatching!,
            onTap: () {}, // TODO: Implement watch functionality
          ),
        
        const Spacer(),
        
        // Privacy indicator
        if (entry.privacy != null && entry.privacy != 'public')
          Icon(
            entry.privacy == 'private' ? Icons.lock : Icons.group,
            size: 16,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        
        const SizedBox(width: 8),
        
        // More actions menu
        PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          onSelected: (value) {
            switch (value) {
              case 'bookmark':
                onBookmark?.call();
                break;
              case 'share':
                // TODO: Implement share functionality
                break;
              case 'report':
                // TODO: Implement report functionality
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'bookmark',
              child: Row(
                children: [
                  Icon(
                    entry.isBookmarked ? Icons.bookmark_remove : Icons.bookmark_add,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(entry.isBookmarked ? 'Remove bookmark' : 'Bookmark'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'share',
              child: Row(
                children: [
                  Icon(Icons.share, size: 20),
                  SizedBox(width: 12),
                  Text('Share'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'report',
              child: Row(
                children: [
                  Icon(Icons.flag, size: 20),
                  SizedBox(width: 12),
                  Text('Report'),
                ],
              ),
            ),
          ],
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
      content += '...';
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
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: effectiveColor,
            ),
            if (count > 0) ...[
              const SizedBox(width: 6),
              Text(
                _formatCount(count),
                style: theme.textTheme.bodySmall?.copyWith(
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