import 'package:flutter/material.dart';
import 'package:mindwell_api/mindwell_api.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.profile});

  final MwProfile profile;

  @override
  Widget build(BuildContext context) {
    final createdAt = profile.createdAt != null
        ? DateTime.fromMillisecondsSinceEpoch((profile.createdAt! * 1000).toInt())
        : null;
    final daysCount = createdAt != null ? DateTime.now().difference(createdAt).inDays : 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (profile.title != null && profile.title!.isNotEmpty) ...[
              Text(profile.title!, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 16),
            ],
            _InfoRow(
              label: 'Gender',
              value: profile.gender?.toString() ?? 'Not specified',
            ),
            _InfoRow(
              label: 'Active Days',
              value: daysCount.toString(),
            ),
            if (profile.invitedBy != null)
              _InfoRow(
                label: 'Invited By',
                value: profile.invitedBy!.name!,
              ),
            _InfoRow(
              label: 'Privacy',
              value: profile.privacy?.toString() ?? 'Public',
            ),
            if (profile.rank != null)
              _InfoRow(
                label: 'Rank',
                value: profile.rank.toString(),
              ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
