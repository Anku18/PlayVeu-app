import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../theme/app_theme.dart';
import '../widgets/app_icon.dart';

class EquipmentScreen extends StatelessWidget {
  const EquipmentScreen({super.key});

  static const _items = <_EquipmentItem>[
    _EquipmentItem(
      name: 'Yonex Astrox Racket',
      sport: 'Badminton',
      price: '₹50 / hour',
      icon: HugeIcons.strokeRoundedTennisRacket,
    ),
    _EquipmentItem(
      name: 'Football Size 5',
      sport: 'Football',
      price: '₹30 / hour',
      icon: HugeIcons.strokeRoundedFootball,
    ),
    _EquipmentItem(
      name: 'Cricket Kit',
      sport: 'Cricket',
      price: '₹80 / hour',
      icon: HugeIcons.strokeRoundedCricketBat,
    ),
    _EquipmentItem(
      name: 'TT Paddle Set',
      sport: 'Table Tennis',
      price: '₹40 / hour',
      icon: HugeIcons.strokeRoundedTableTennisBat,
    ),
    _EquipmentItem(
      name: 'Chess Set',
      sport: 'Chess',
      price: '₹20 / session',
      icon: HugeIcons.strokeRoundedChessKing,
    ),
    _EquipmentItem(
      name: 'Carrom Board',
      sport: 'Carrom',
      price: '₹35 / hour',
      icon: HugeIcons.strokeRoundedGame,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      itemCount: _items.length + 1,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == 0) {
          return const Text(
            'Rent gear for your next game',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.textSecondary,
            ),
          );
        }

        final item = _items[index - 1];
        return _EquipmentCard(item: item);
      },
    );
  }
}

class _EquipmentItem {
  const _EquipmentItem({
    required this.name,
    required this.sport,
    required this.price,
    required this.icon,
  });

  final String name;
  final String sport;
  final String price;
  final List<List<dynamic>> icon;
}

class _EquipmentCard extends StatelessWidget {
  const _EquipmentCard({required this.item});

  final _EquipmentItem item;

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
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: AppIcon(item.icon, color: AppColors.primary, size: 26),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.navy,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.sport,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.price,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
            ),
            FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${item.name} rental coming soon')),
                );
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size(72, 40),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Rent'),
            ),
          ],
        ),
      ),
    );
  }
}
