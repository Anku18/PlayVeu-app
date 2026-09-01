import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../theme/app_theme.dart';
import '../widgets/app_icon.dart';
import 'credits_screen.dart';
import 'equipment_screen.dart';
import 'leaderboard_screen.dart';
import 'login_screen.dart';
import 'play_screen.dart';
import 'venues_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _tabIndex = 0;

  static const _availableCredits = 20;
  static const _titles = ['Home', 'Equipment', 'Venue', 'Play', 'Leaderboard'];

  void _selectTab(int index) {
    setState(() => _tabIndex = index);
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _openCredits() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => Scaffold(
          backgroundColor: AppColors.backgroundBottom,
          appBar: AppBar(title: const Text('Credits')),
          body: const CreditsScreen(credits: _availableCredits),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.backgroundBottom,
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Menu',
          icon: const AppIcon(HugeIcons.strokeRoundedMenu01, size: 22),
          onPressed: _openDrawer,
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/app_icon.png',
                width: 32,
                height: 32,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              _titles[_tabIndex],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.navy,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications')),
              );
            },
            icon: const AppIcon(HugeIcons.strokeRoundedNotification03, size: 22),
          ),
        ],
      ),
      drawer: _HomeDrawer(
        selectedTab: _tabIndex,
        onSelectTab: (index) {
          Navigator.of(context).pop();
          _selectTab(index);
        },
        onOpenCredits: () {
          Navigator.of(context).pop();
          _openCredits();
        },
        onPlaceholder: (label) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('$label is coming soon')));
        },
        onLogout: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
            (route) => false,
          );
        },
      ),
      body: IndexedStack(
        index: _tabIndex,
        children: [
          _HomeDashboard(
            credits: _availableCredits,
            onOpenCredits: _openCredits,
          ),
          const EquipmentScreen(),
          const VenuesScreen(),
          const PlayScreen(),
          const LeaderboardScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: _selectTab,
        destinations: const [
          NavigationDestination(
            icon: AppIcon(HugeIcons.strokeRoundedHome01),
            selectedIcon: AppIcon(
              HugeIcons.strokeRoundedHome01,
              strokeWidth: 2.4,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: AppIcon(HugeIcons.strokeRoundedDumbbell02),
            selectedIcon: AppIcon(
              HugeIcons.strokeRoundedDumbbell02,
              strokeWidth: 2.4,
            ),
            label: 'Equipment',
          ),
          NavigationDestination(
            icon: AppIcon(HugeIcons.strokeRoundedLocation01),
            selectedIcon: AppIcon(
              HugeIcons.strokeRoundedLocation01,
              strokeWidth: 2.4,
            ),
            label: 'Venue',
          ),
          NavigationDestination(
            icon: AppIcon(HugeIcons.strokeRoundedWorkoutRun),
            selectedIcon: AppIcon(
              HugeIcons.strokeRoundedWorkoutRun,
              strokeWidth: 2.4,
            ),
            label: 'Play',
          ),
          NavigationDestination(
            icon: AppIcon(HugeIcons.strokeRoundedChampion),
            selectedIcon: AppIcon(
              HugeIcons.strokeRoundedChampion,
              strokeWidth: 2.4,
            ),
            label: 'Leaderboard',
          ),
        ],
      ),
    );
  }
}

class _HomeDrawer extends StatelessWidget {
  const _HomeDrawer({
    required this.selectedTab,
    required this.onSelectTab,
    required this.onOpenCredits,
    required this.onPlaceholder,
    required this.onLogout,
  });

  final int selectedTab;
  final ValueChanged<int> onSelectTab;
  final VoidCallback onOpenCredits;
  final ValueChanged<String> onPlaceholder;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/app_icon.png',
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PlayVue',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.navy,
                          ),
                        ),
                        Text(
                          'Elevate your game',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.fieldBorder),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _DrawerTile(
                    icon: HugeIcons.strokeRoundedUser,
                    label: 'Profile',
                    onTap: () => onPlaceholder('Profile'),
                  ),
                  _DrawerTile(
                    icon: HugeIcons.strokeRoundedHome01,
                    label: 'Home',
                    selected: selectedTab == 0,
                    onTap: () => onSelectTab(0),
                  ),
                  _DrawerTile(
                    icon: HugeIcons.strokeRoundedDumbbell02,
                    label: 'Equipment',
                    selected: selectedTab == 1,
                    onTap: () => onSelectTab(1),
                  ),
                  _DrawerTile(
                    icon: HugeIcons.strokeRoundedLocation01,
                    label: 'Venue',
                    selected: selectedTab == 2,
                    onTap: () => onSelectTab(2),
                  ),
                  _DrawerTile(
                    icon: HugeIcons.strokeRoundedWorkoutRun,
                    label: 'Play',
                    selected: selectedTab == 3,
                    onTap: () => onSelectTab(3),
                  ),
                  _DrawerTile(
                    icon: HugeIcons.strokeRoundedChampion,
                    label: 'Leaderboard',
                    selected: selectedTab == 4,
                    onTap: () => onSelectTab(4),
                  ),
                  _DrawerTile(
                    icon: HugeIcons.strokeRoundedWallet01,
                    label: 'Credits',
                    onTap: onOpenCredits,
                  ),
                  _DrawerTile(
                    icon: HugeIcons.strokeRoundedCalendar03,
                    label: 'Bookings',
                    onTap: () => onPlaceholder('Bookings'),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.fieldBorder),
            _DrawerTile(
              icon: HugeIcons.strokeRoundedSettings01,
              label: 'Settings',
              onTap: () => onPlaceholder('Settings'),
            ),
            _DrawerTile(
              icon: HugeIcons.strokeRoundedLogout01,
              label: 'Logout',
              onTap: onLogout,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  final List<List<dynamic>> icon;
  final String label;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AppIcon(
        icon,
        size: 22,
        color: selected ? AppColors.primary : AppColors.navy,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          color: selected ? AppColors.primary : AppColors.navy,
        ),
      ),
      selected: selected,
      selectedTileColor: AppColors.primary.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }
}

class _HomeDashboard extends StatelessWidget {
  const _HomeDashboard({required this.credits, required this.onOpenCredits});

  final int credits;
  final VoidCallback onOpenCredits;

  static const _games = <(String, List<List<dynamic>>)>[
    ('Badminton', HugeIcons.strokeRoundedBadminton),
    ('Football', HugeIcons.strokeRoundedFootball),
    ('Box Cricket', HugeIcons.strokeRoundedCricketBat),
    ('Carrom', HugeIcons.strokeRoundedGame),
    ('Chess', HugeIcons.strokeRoundedChessKing),
    ('Table Tennis', HugeIcons.strokeRoundedTableTennisBat),
    ('Cycling', HugeIcons.strokeRoundedBicycle01),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          top: -36,
          right: -28,
          child: IgnorePointer(
            child: _DecorCircle(
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
            child: _DecorCircle(
              size: 170,
              color: Color(0x221E9BE8),
              ringColor: Color(0x335EC8F8),
            ),
          ),
        ),
        ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            _ProfileCard(credits: credits, onOpenCredits: onOpenCredits),
            const SizedBox(height: 28),
            const Text(
              'Explore Games',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.navy,
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 138,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _games.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final game = _games[index];
                  return _GameCard(name: game.$1, icon: game.$2);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DecorCircle extends StatelessWidget {
  const _DecorCircle({
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

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.credits, required this.onOpenCredits});

  final int credits;
  final VoidCallback onOpenCredits;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 4,
      shadowColor: AppColors.primary.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.fieldBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primarySoft, AppColors.primary],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.28),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'L',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Logesh',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.navy,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '+91 9999999999',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Material(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile is coming soon')),
                      );
                    },
                    child: const SizedBox(
                      width: 36,
                      height: 36,
                      child: Center(
                        child: AppIcon(
                          HugeIcons.strokeRoundedArrowRight01,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Material(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                onTap: onOpenCredits,
                borderRadius: BorderRadius.circular(14),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      const AppIcon(
                        HugeIcons.strokeRoundedWallet01,
                        size: 20,
                        color: AppColors.primaryDark,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$credits Credits',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.navy,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GameCard extends StatelessWidget {
  const _GameCard({required this.name, required this.icon});

  final String name;
  final List<List<dynamic>> icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 118,
      child: Material(
        color: Colors.white,
        elevation: 3,
        shadowColor: AppColors.primary.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: AppIcon(icon, color: AppColors.primary, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.navy,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

