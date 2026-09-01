import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../theme/app_theme.dart';
import '../widgets/app_icon.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  static const _players = <_RankedPlayer>[
    _RankedPlayer(rank: 1, name: 'Arjun Rao', points: 1840, isYou: false),
    _RankedPlayer(rank: 2, name: 'Meera Shah', points: 1720, isYou: false),
    _RankedPlayer(rank: 3, name: 'Logesh', points: 1650, isYou: true),
    _RankedPlayer(rank: 4, name: 'Kabir Singh', points: 1490, isYou: false),
    _RankedPlayer(rank: 5, name: 'Ananya Iyer', points: 1380, isYou: false),
    _RankedPlayer(rank: 6, name: 'Rahul Nair', points: 1210, isYou: false),
    _RankedPlayer(rank: 7, name: 'Sneha Patel', points: 1140, isYou: false),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      itemCount: _players.length + 1,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        if (index == 0) {
          return const Text(
            'This week',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.textSecondary,
            ),
          );
        }

        return _RankTile(player: _players[index - 1]);
      },
    );
  }
}

class _RankedPlayer {
  const _RankedPlayer({
    required this.rank,
    required this.name,
    required this.points,
    required this.isYou,
  });

  final int rank;
  final String name;
  final int points;
  final bool isYou;
}

class _RankTile extends StatelessWidget {
  const _RankTile({required this.player});

  final _RankedPlayer player;

  Color get _badgeColor {
    switch (player.rank) {
      case 1:
        return const Color(0xFFFFC107);
      case 2:
        return const Color(0xFF90A4AE);
      case 3:
        return const Color(0xFFCD7F32);
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: player.isYou
          ? AppColors.primary.withValues(alpha: 0.08)
          : Colors.white,
      elevation: player.isYou ? 0 : 2,
      shadowColor: AppColors.primary.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: player.isYou ? AppColors.primary : AppColors.fieldBorder,
            width: player.isYou ? 1.4 : 1,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 36,
              child: player.rank <= 3
                  ? AppIcon(
                      HugeIcons.strokeRoundedChampion,
                      color: _badgeColor,
                      size: 26,
                    )
                  : Text(
                      '${player.rank}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.navy,
                      ),
                    ),
            ),
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primary.withValues(alpha: 0.16),
              child: Text(
                player.name.characters.first,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryDark,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.navy,
                    ),
                  ),
                  if (player.isYou)
                    const Text(
                      'You',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryDark,
                      ),
                    ),
                ],
              ),
            ),
            Text(
              '${player.points} pts',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColors.navy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
