import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'home/home_screen.dart';
import 'date_now/date_now_screen.dart';
import 'chat/messages_screen.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeScreen(),
      const DateNowScreen(),
      const _CleanPlaceholderPage(
        title: 'Admirers',
        icon: Icons.favorite_border_rounded,
      ),
      const MessagesScreen(),
      const _CleanPlaceholderPage(
        title: 'Events',
        icon: Icons.calendar_today_outlined,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentIndex,
        onTabSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class _CleanPlaceholderPage extends StatelessWidget {
  final String title;
  final IconData icon;

  const _CleanPlaceholderPage({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 52, color: AppColors.textMuted),
            const SizedBox(height: 12),
            Text(
              'No new updates in $title',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
