import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../theme/app_theme.dart';
import '../widgets/app_icon.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  static const _matches = <_OpenMatch>[
    _OpenMatch(
      game: 'Badminton Doubles',
      venue: 'Smash Arena',
      time: 'Today, 6:00 PM',
      spots: '1 spot left',
      icon: HugeIcons.strokeRoundedBadminton,
    ),
    _OpenMatch(
      game: 'Football 5v5',
      venue: 'Champions Sports Club',
      time: 'Tomorrow, 7:30 AM',
      spots: '3 spots left',
      icon: HugeIcons.strokeRoundedFootball,
    ),
    _OpenMatch(
      game: 'Box Cricket',
      venue: 'PlayVue Sports Academy',
      time: 'Sat, 5:00 PM',
      spots: '4 spots left',
      icon: HugeIcons.strokeRoundedCricketBat,
    ),
    _OpenMatch(
      game: 'Table Tennis',
      venue: 'Elite Sports Arena',
      time: 'Sun, 11:00 AM',
      spots: '2 spots left',
      icon: HugeIcons.strokeRoundedTableTennisBat,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      itemCount: _matches.length + 2,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Material(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(18),
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Host a game coming soon')),
                );
              },
              borderRadius: BorderRadius.circular(18),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    AppIcon(
                      HugeIcons.strokeRoundedAddCircle,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Host a game and invite players',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.navy,
                        ),
                      ),
                    ),
                    AppIcon(
                      HugeIcons.strokeRoundedArrowRight01,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (index == 1) {
          return const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              'Open matches',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.navy,
              ),
            ),
          );
        }

        return _MatchCard(match: _matches[index - 2]);
      },
    );
  }
}

class _OpenMatch {
  const _OpenMatch({
    required this.game,
    required this.venue,
    required this.time,
    required this.spots,
    required this.icon,
  });

  final String game;
  final String venue;
  final String time;
  final String spots;
  final List<List<dynamic>> icon;
}

class _MatchCard extends StatelessWidget {
  const _MatchCard({required this.match});

  final _OpenMatch match;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 3,
      shadowColor: AppColors.primary.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.fieldBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: AppIcon(match.icon, color: AppColors.primary, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        match.game,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.navy,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        match.venue,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const AppIcon(
                  HugeIcons.strokeRoundedClock01,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  match.time,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.navy,
                  ),
                ),
                const Spacer(),
                Text(
                  match.spots,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Joining ${match.game} coming soon')),
                  );
                },
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(44),
                ),
                child: const Text('Join'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
