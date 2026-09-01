import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../theme/app_theme.dart';
import '../widgets/app_icon.dart';
import 'venue_details_screen.dart';

class VenuesScreen extends StatelessWidget {
  const VenuesScreen({super.key});

  static const List<Map<String, dynamic>> venues = [
    {
      'name': 'PlayVue Sports Academy',
      'image': 'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=800&auto=format&fit=crop&q=60',
      'rating': 4.6,
      'location': 'Bengaluru, Karnataka',
      'description': 'A modern sports academy offering multiple indoor and outdoor games.',
      'games': ['Badminton', 'Football', 'Cricket'],
      'facilities': ['Parking', 'Changing Rooms', 'Drinking Water'],
      'hours': '6:00 AM - 10:00 PM',
      'pricing': {
        '30 Mins': 300,
        '1 Hour': 500,
        '2 Hours': 900,
      }
    },
    {
      'name': 'Elite Sports Arena',
      'image': 'https://images.unsplash.com/photo-1521537634581-0dced2fee2ef?w=800&auto=format&fit=crop&q=60',
      'rating': 4.8,
      'location': 'HSR Layout, Bengaluru',
      'description': 'Premium sports facility with international standard courts.',
      'games': ['Badminton', 'Tennis', 'Table Tennis'],
      'facilities': ['AC Courts', 'Shower', 'Lounge'],
      'hours': '5:00 AM - 11:00 PM',
      'pricing': {
        '30 Mins': 400,
        '1 Hour': 700,
        '2 Hours': 1200,
      }
    },
    {
      'name': 'Smash Arena',
      'image': 'https://images.unsplash.com/photo-1626225453014-a9ac938c647d?w=800&auto=format&fit=crop&q=60',
      'rating': 4.4,
      'location': 'Indiranagar, Bengaluru',
      'description': 'Best destination for badminton and squash lovers.',
      'games': ['Badminton', 'Squash'],
      'facilities': ['Pro Shop', 'Coaching', 'Cafeteria'],
      'hours': '6:00 AM - 10:00 PM',
      'pricing': {
        '30 Mins': 250,
        '1 Hour': 450,
        '2 Hours': 800,
      }
    },
    {
      'name': 'Champions Sports Club',
      'image': 'https://images.unsplash.com/photo-1517466787929-bc90951d0974?w=800&auto=format&fit=crop&q=60',
      'rating': 4.5,
      'location': 'Whitefield, Bengaluru',
      'description': 'Large multi-sport complex for families and professionals.',
      'games': ['Football', 'Cricket', 'Swimming'],
      'facilities': ['Large Ground', 'Floodlights', 'Lockers'],
      'hours': '6:00 AM - 11:00 PM',
      'pricing': {
        '30 Mins': 350,
        '1 Hour': 600,
        '2 Hours': 1000,
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: venues.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final venue = venues[index];
        return _VenueCard(
          venue: venue,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => VenueDetailsScreen(venue: venue),
              ),
            );
          },
        );
      },
    );
  }
}

class _VenueCard extends StatelessWidget {
  const _VenueCard({required this.venue, required this.onTap});

  final Map<String, dynamic> venue;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 4,
      shadowColor: AppColors.primary.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.fieldBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  venue['image'],
                  height: 160,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 160,
                    color: AppColors.primarySoft.withValues(alpha: 0.2),
                    child: const AppIcon(
                      HugeIcons.strokeRoundedImageNotFound01,
                      color: AppColors.primary,
                      size: 50,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            venue['name'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.navy,
                            ),
                          ),
                        ),
                        const AppIcon(
                          HugeIcons.strokeRoundedArrowRight01,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const AppIcon(
                          HugeIcons.strokeRoundedStar,
                          color: Colors.amber,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          venue['rating'].toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.navy,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const AppIcon(
                          HugeIcons.strokeRoundedLocation01,
                          color: AppColors.primary,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          venue['location'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
