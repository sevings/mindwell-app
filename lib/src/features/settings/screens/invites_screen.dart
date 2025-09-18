import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/widgets/platform_app_bar.dart';
import '../providers/invites_provider.dart';

/// Screen that displays the user's available invites.
///
/// This screen features:
/// - A platform-adaptive [PlatformAppBar] with title and back navigation
/// - Display of the number of available invites
/// - Instructional text explaining how invites work
/// - Integration with [InvitesProvider] for state management
/// - Platform-adaptive UI that uses Material Design on Android and Cupertino on iOS
class InvitesScreen extends ConsumerStatefulWidget {
  const InvitesScreen({super.key});

  @override
  ConsumerState<InvitesScreen> createState() => _InvitesScreenState();
}

class _InvitesScreenState extends ConsumerState<InvitesScreen> {
  @override
  void initState() {
    super.initState();

    // Initialize invites data when the screen is first displayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(invitesProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: PlatformAppBar(
        title: Text(
          l10n?.invites ?? 'Invites',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        automaticallyImplyLeading: true,
        showHamburgerMenu: false,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(invitesProvider);

          return state.when(
            initial: () => _buildLoadingState(l10n, theme, colorScheme),
            loading: () => _buildLoadingState(l10n, theme, colorScheme),
            loaded: (invites) =>
                _buildLoadedState(invites, l10n, theme, colorScheme),
            error: (message) =>
                _buildErrorState(message, l10n, theme, colorScheme),
          );
        },
      ),
    );
  }

  /// Build the loading state with a centered loading indicator.
  Widget _buildLoadingState(
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: colorScheme.primary),
          const SizedBox(height: MindwellSpacing.md),
          Text(
            l10n?.loading ?? 'Loading...',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  /// Build the loaded state with invites information.
  Widget _buildLoadedState(
    MwAccountInvitesGet200Response invites,
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    final inviteCount = invites.invites?.length ?? 0;

    return RefreshIndicator(
      onRefresh: () => ref.read(invitesProvider.notifier).refresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(MindwellSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Invite count card
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(MindwellSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person_add_outlined,
                          size: 32,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: MindwellSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n?.availableInvites ?? 'Available Invites',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                inviteCount.toString(),
                                style: theme.textTheme.displaySmall?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: MindwellSpacing.lg),

            // Description section
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(MindwellSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: colorScheme.primary),
                        const SizedBox(width: MindwellSpacing.sm),
                        Text(
                          l10n?.howItWorks ?? 'How it works',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: MindwellSpacing.md),
                    Text(
                      l10n?.invitesDescription ??
                          'You can give an invite to another user on their profile page, granting that user full rights.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.8),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: MindwellSpacing.lg),

            // Additional information
            if (inviteCount > 0) ...[
              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(MindwellSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.tips_and_updates_outlined,
                            color: colorScheme.secondary,
                          ),
                          const SizedBox(width: MindwellSpacing.sm),
                          Text(
                            l10n?.tip ?? 'Tip',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: MindwellSpacing.md),
                      Text(
                        l10n?.inviteTip ??
                            'Visit any user\'s profile page to send them an invite. They will receive full access to the platform.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.8),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              // Empty state
              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(MindwellSpacing.xl),
                  child: Column(
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 64,
                        color: colorScheme.onSurface.withValues(alpha: 0.4),
                      ),
                      const SizedBox(height: MindwellSpacing.md),
                      Text(
                        l10n?.noInvitesAvailable ?? 'No invites available',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                      const SizedBox(height: MindwellSpacing.sm),
                      Text(
                        l10n?.noInvitesDescription ??
                            'You don\'t have any invites to give out at the moment.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Build the error state with retry functionality.
  Widget _buildErrorState(
    String message,
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(MindwellSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: colorScheme.error),
            const SizedBox(height: MindwellSpacing.md),
            Text(
              l10n?.error ?? 'Error',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: colorScheme.error,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: MindwellSpacing.sm),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: MindwellSpacing.lg),
            ElevatedButton(
              onPressed: () {
                ref.read(invitesProvider.notifier).refresh();
              },
              child: Text(l10n?.retry ?? 'Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
