import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../theme/app_theme.dart';
import '../widgets/app_icon.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key, this.credits = 20});

  final int credits;

  static const _plans = <(String, int, bool)>[
    ('₹100', 10, false),
    ('₹250', 30, true),
    ('₹500', 70, false),
    ('₹1,000', 160, false),
  ];

  void _onBuyNow(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Purchase flow coming soon')));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          top: -36,
          right: -28,
          child: IgnorePointer(
            child: _CreditsDecorCircle(
              size: 150,
              color: Color(0x332B9FE8),
              ringColor: Color(0x221E9BE8),
            ),
          ),
        ),
        const Positioned(
          bottom: -24,
          left: -40,
          child: IgnorePointer(
            child: _CreditsDecorCircle(
              size: 170,
              color: Color(0x221E9BE8),
              ringColor: Color(0x335EC8F8),
            ),
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CreditsSummaryCard(credits: credits),
              const SizedBox(height: 28),
              const Text(
                'Buy Credits',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.navy,
                ),
              ),
              const SizedBox(height: 14),
              for (var i = 0; i < _plans.length; i++) ...[
                if (i > 0) const SizedBox(height: 12),
                _CreditPlanCard(
                  price: _plans[i].$1,
                  credits: _plans[i].$2,
                  isPopular: _plans[i].$3,
                  onBuyNow: () => _onBuyNow(context),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _CreditsSummaryCard extends StatelessWidget {
  const _CreditsSummaryCard({required this.credits});

  final int credits;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 4,
      shadowColor: AppColors.primary.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.fieldBorder),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withValues(alpha: 0.12),
              Colors.white,
              AppColors.primarySoft.withValues(alpha: 0.18),
            ],
          ),
        ),
        child: Column(
          children: [
            const Text(
              'Your Credits',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: 64,
              height: 64,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              child: const AppIcon(
                HugeIcons.strokeRoundedWallet01,
                color: AppColors.primary,
                size: 32,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              '$credits Credits',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: AppColors.navy,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreditPlanCard extends StatelessWidget {
  const _CreditPlanCard({
    required this.price,
    required this.credits,
    required this.isPopular,
    required this.onBuyNow,
  });

  final String price;
  final int credits;
  final bool isPopular;
  final VoidCallback onBuyNow;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: isPopular ? 5 : 3,
      shadowColor: AppColors.primary.withValues(alpha: isPopular ? 0.24 : 0.14),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isPopular ? AppColors.primary : AppColors.fieldBorder,
            width: isPopular ? 1.6 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.navy,
                  ),
                ),
                const Spacer(),
                if (isPopular)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'Popular',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '$credits Credits',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryDark,
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onBuyNow,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(46),
                ),
                child: const Text('Buy Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreditsDecorCircle extends StatelessWidget {
  const _CreditsDecorCircle({
    required this.size,
    required this.color,
    required this.ringColor,
  });

  final double size;
  final Color color;
  final Color ringColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: ringColor, width: 14),
      ),
    );
  }
}
