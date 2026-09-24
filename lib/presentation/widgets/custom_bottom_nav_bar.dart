import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;
  final int unreadChatCount;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    this.unreadChatCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildHomeNavItem(),
              _buildNavItem(
                index: 1,
                label: 'Date Now',
                icon: Icons.play_circle_outline_rounded,
                activeIcon: Icons.play_circle_filled_rounded,
              ),
              _buildNavItem(
                index: 2,
                label: 'Admirers',
                icon: Icons.favorite_border_rounded,
                activeIcon: Icons.favorite_rounded,
              ),
              _buildNavItem(
                index: 3,
                label: 'Chat',
                icon: Icons.chat_bubble_outline_rounded,
                activeIcon: Icons.chat_bubble_rounded,
                badgeCount: unreadChatCount,
              ),
              _buildNavItem(
                index: 4,
                label: 'Events',
                icon: Icons.calendar_today_outlined,
                activeIcon: Icons.calendar_month_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeNavItem() {
    final bool isSelected = selectedIndex == 0;
    final color = isSelected ? AppColors.primary : const Color(0xFF4A4A4A);

    return GestureDetector(
      onTap: () => onTabSelected(0),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 28,
              height: 28,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.home_outlined,
                    size: 27,
                    color: color,
                  ),
                  Positioned(
                    bottom: 3,
                    child: Icon(
                      Icons.favorite,
                      size: 9,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Home',
              style: TextStyle(
                color: isSelected ? AppColors.primary : const Color(0xFF4A4A4A),
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required IconData icon,
    required IconData activeIcon,
    int? badgeCount,
  }) {
    final bool isSelected = selectedIndex == index;
    final color = isSelected ? AppColors.primary : const Color(0xFF4A4A4A);

    return GestureDetector(
      onTap: () => onTabSelected(index),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  isSelected ? activeIcon : icon,
                  size: 26,
                  color: color,
                ),
                if (badgeCount != null && badgeCount > 0 && !isSelected)
                  Positioned(
                    top: -4,
                    right: -6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '$badgeCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
