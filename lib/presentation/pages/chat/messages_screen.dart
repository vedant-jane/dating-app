import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/constants/app_colors.dart';
import 'chat_conversation_page.dart';

class MatchItem {
  final String name;
  final int age;
  final String imageUrl;
  final int unreadCount;
  final bool hasStory;

  MatchItem({
    required this.name,
    required this.age,
    required this.imageUrl,
    this.unreadCount = 0,
    this.hasStory = true,
  });
}

class ChatListItem {
  final String name;
  final int age;
  final int matchPercentage;
  final String lastMessage;
  final String time;
  final String imageUrl;
  final int unreadCount;
  final bool isTyping;
  final String? milestoneProgress;
  final bool giftUnlocked;

  ChatListItem({
    required this.name,
    required this.age,
    required this.matchPercentage,
    required this.lastMessage,
    required this.time,
    required this.imageUrl,
    this.unreadCount = 0,
    this.isTyping = false,
    this.milestoneProgress,
    this.giftUnlocked = false,
  });
}

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  String _selectedFilter = 'All';

  final List<MatchItem> _newMatches = [
    MatchItem(
      name: 'Sarah',
      age: 23,
      imageUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=300&q=80',
      unreadCount: 1,
    ),
    MatchItem(
      name: 'Aanya',
      age: 25,
      imageUrl:
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80',
    ),
    MatchItem(
      name: 'Liam',
      age: 26,
      imageUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80',
    ),
    MatchItem(
      name: 'Chloe',
      age: 24,
      imageUrl:
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=300&q=80',
    ),
    MatchItem(
      name: 'Dev',
      age: 27,
      imageUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80',
    ),
  ];

  final List<ChatListItem> _conversations = [
    ChatListItem(
      name: 'Aanya',
      age: 25,
      matchPercentage: 92,
      lastMessage: "Can't wait to see you tonight at the...",
      time: '1m',
      imageUrl:
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80',
      unreadCount: 2,
      giftUnlocked: true,
    ),
    ChatListItem(
      name: 'Jordan',
      age: 27,
      matchPercentage: 88,
      lastMessage: 'Typing...',
      time: 'Just now',
      imageUrl:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=300&q=80',
      isTyping: true,
      milestoneProgress: '16/25 for Premium Rose',
    ),
    ChatListItem(
      name: 'Marcus',
      age: 29,
      matchPercentage: 93,
      lastMessage: 'That sounds like an amazing hobby! Hav...',
      time: '0.2h',
      imageUrl:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=300&q=80',
      milestoneProgress: 'Deadline 14h',
    ),
    ChatListItem(
      name: 'Elena',
      age: 23,
      matchPercentage: 95,
      lastMessage: "Hey! I'm heading over now.",
      time: '3h',
      imageUrl:
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=300&q=80',
      milestoneProgress: '22/25 for Silver Ring',
    ),
    ChatListItem(
      name: 'Rohan',
      age: 28,
      matchPercentage: 81,
      lastMessage: 'Coffee sounds perfect, see you at 6!',
      time: '1d',
      imageUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filters = ['All', 'Unread', 'Online', 'Nearby', 'Date Invites'];

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Messages',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.divider),
                        ),
                        child: const Icon(Icons.search_rounded,
                            size: 20, color: AppColors.textDark),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.divider),
                        ),
                        child: const Icon(Icons.tune_rounded,
                            size: 20, color: AppColors.textDark),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.divider),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search_rounded,
                        color: AppColors.textMuted, size: 20),
                    SizedBox(width: 10),
                    Text(
                      'Search matches or messages',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // New Matches Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'NEW MATCHES',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primarySoft,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '12',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'See all',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Horizontal Matches List
            SizedBox(
              height: 90,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _newMatches.length,
                itemBuilder: (context, index) {
                  final match = _newMatches[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2.5),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppColors.primaryGradient,
                              ),
                              child: CircleAvatar(
                                radius: 26,
                                backgroundImage: CachedNetworkImageProvider(
                                    match.imageUrl),
                              ),
                            ),
                            if (match.unreadCount > 0)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '${match.unreadCount}+',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          match.name,
                          style: const TextStyle(
                            color: AppColors.textDark,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black87 : Colors.white,
                          borderRadius: BorderRadius.circular(16),
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
            const SizedBox(height: 12),

            // Conversation List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _conversations.length,
                separatorBuilder: (context, index) =>
                    const Divider(height: 16, color: AppColors.divider),
                itemBuilder: (context, index) {
                  final chat = _conversations[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChatConversationPage(
                            userName: chat.name,
                            userImage: chat.imageUrl,
                          ),
                        ),
                      );
                    },
                    leading: Stack(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundImage:
                              CachedNetworkImageProvider(chat.imageUrl),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: AppColors.onlineGreen,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${chat.name}, ${chat.age}',
                              style: const TextStyle(
                                color: AppColors.textDark,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceMuted,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${chat.matchPercentage}% Match',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          chat.time,
                          style: const TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            if (chat.isTyping)
                              const Text(
                                'Typing...  ',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            else
                              Expanded(
                                child: Text(
                                  chat.lastMessage,
                                  style: TextStyle(
                                    color: chat.unreadCount > 0
                                        ? AppColors.textDark
                                        : AppColors.textSecondary,
                                    fontSize: 13,
                                    fontWeight: chat.unreadCount > 0
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            if (chat.unreadCount > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${chat.unreadCount}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (chat.giftUnlocked) ...[
                          const SizedBox(height: 4),
                          const Row(
                            children: [
                              Text('🎁 ', style: TextStyle(fontSize: 11)),
                              Text(
                                'Gift unlocked!',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                        if (chat.milestoneProgress != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            chat.milestoneProgress!,
                            style: const TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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
