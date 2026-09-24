import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/constants/app_colors.dart';
import '../chat/chat_conversation_page.dart';

class NotificationItem {
  final String title;
  final String description;
  final String time;
  final String actionLabel;
  final String? avatarUrl;
  final IconData? icon;
  final String badgeEmoji;
  final VoidCallback? onAction;

  NotificationItem({
    required this.title,
    required this.description,
    required this.time,
    required this.actionLabel,
    this.avatarUrl,
    this.icon,
    required this.badgeEmoji,
    this.onAction,
  });
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedFilter = 'All 55';

  @override
  Widget build(BuildContext context) {
    final filters = [
      'All 55',
      'Likes & roses',
      'Matches',
      'Gifts',
      'Date Requests'
    ];

    final notifications = [
      NotificationItem(
        title: 'Dev, 27 sent you a Rose',
        description:
            '"Your trekking photos sold me — let\'s swap trail stories."',
        time: '12 min ago',
        actionLabel: 'View profile',
        avatarUrl:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80',
        badgeEmoji: '🌹',
      ),
      NotificationItem(
        title: 'Arjun, 28 complimented your About',
        description:
            '"Equally driven and equally curious — that line got me."',
        time: '3h ago',
        actionLabel: 'View profile',
        avatarUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80',
        badgeEmoji: '💬',
      ),
      NotificationItem(
        title: "It's a match with Aanya, 25",
        description:
            'You both liked each other. Say hello before the spark fades.',
        time: '4h ago',
        actionLabel: 'Send a message',
        avatarUrl:
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80',
        badgeEmoji: '✨',
        onAction: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ChatConversationPage(
                userName: 'Aanya',
              ),
            ),
          );
        },
      ),
      NotificationItem(
        title: 'Elena, 23 sent you a message',
        description:
            '"Haha okay that café pick was elite. When are you free?"',
        time: '5h ago',
        actionLabel: 'Open chat',
        avatarUrl:
            'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=300&q=80',
        badgeEmoji: '💬',
        onAction: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ChatConversationPage(
                userName: 'Elena',
              ),
            ),
          );
        },
      ),
      NotificationItem(
        title: 'Kabir approved your date request',
        description: 'Coffee at Blue Tokai, Today 7:00 PM • Koregaon Park',
        time: '7h ago',
        actionLabel: 'Open chat',
        icon: Icons.coffee_rounded,
        badgeEmoji: '☕',
        onAction: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ChatConversationPage(
                userName: 'Kabir',
              ),
            ),
          );
        },
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notifications',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),
            Text(
              '9 new updates',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All marked as read')),
              );
            },
            child: const Text(
              'Mark all read',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: filters.map((f) {
                  final isSelected = _selectedFilter == f;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilter = f;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black87 : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : AppColors.divider,
                          ),
                        ),
                        child: Text(
                          f,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppColors.textSecondary,
                            fontSize: 13,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 8),

            // Today label
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                'TODAY',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
            ),

            // Notifications List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final item = notifications[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.divider),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Avatar / Icon
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            if (item.avatarUrl != null)
                              CircleAvatar(
                                radius: 24,
                                backgroundImage: CachedNetworkImageProvider(
                                    item.avatarUrl!),
                              )
                            else
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceLight,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: AppColors.divider),
                                ),
                                child: Icon(item.icon ?? Icons.event_rounded,
                                    color: AppColors.primary, size: 24),
                              ),
                            Positioned(
                              bottom: -2,
                              right: -4,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  item.badgeEmoji,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 14),

                        // Content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.title,
                                      style: const TextStyle(
                                        color: AppColors.textDark,
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    item.time,
                                    style: const TextStyle(
                                      color: AppColors.textMuted,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.description,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13,
                                  height: 1.35,
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: item.onAction ?? () {},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 7),
                                  decoration: BoxDecoration(
                                    color: AppColors.primarySoft,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Text(
                                    item.actionLabel,
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
