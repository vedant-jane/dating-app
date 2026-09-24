import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/constants/app_colors.dart';

class DateNowScreen extends StatefulWidget {
  const DateNowScreen({super.key});

  @override
  State<DateNowScreen> createState() => _DateNowScreenState();
}

class _DateNowScreenState extends State<DateNowScreen> {
  String _selectedDay = 'Today';
  int _cardIndex = 0;

  final List<Map<String, dynamic>> _datePlans = [
    {
      'venue': 'Olive Bar, Mahalaxmi',
      'distance': '3.4 km away',
      'time': '8:30 PM',
      'type': 'Dinner',
      'title': 'Pasta & Honest Chats',
      'description': 'Foodie looking for a dinner buddy 🍝',
      'match': '88% match',
      'spots': 'Just 1',
      'payment': "I'll pay",
      'imageUrl':
          'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=800&q=80',
      'userName': 'Ananya',
      'userAge': 25,
      'userPronouns': 'she/her • Foodie',
      'userAvatar':
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80',
    },
    {
      'venue': 'Blue Tokai, Bandra',
      'distance': '1.8 km away',
      'time': '5:00 PM',
      'type': 'Coffee & Books',
      'title': 'Cold Brew & Good Vibes',
      'description': 'Let us grab coffee and talk about books ☕',
      'match': '94% match',
      'spots': 'Just 1',
      'payment': 'Split bill',
      'imageUrl':
          'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?auto=format&fit=crop&w=800&q=80',
      'userName': 'Meera',
      'userAge': 26,
      'userPronouns': 'she/her • Architect',
      'userAvatar':
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=300&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final days = ['Today', 'Tomorrow', 'Weekend'];
    final currentPlan = _datePlans[_cardIndex % _datePlans.length];

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Top Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Date ',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                      ),
                      children: [
                        TextSpan(
                          text: 'Now',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: const Row(
                      children: [
                        Text('📅', style: TextStyle(fontSize: 13)),
                        SizedBox(width: 6),
                        Text(
                          'My Plans (2)',
                          style: TextStyle(
                            color: AppColors.textDark,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Day Filter Chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: days.map((day) {
                  final isSelected = _selectedDay == day;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDay = day;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 9),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : AppColors.divider,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : [],
                        ),
                        child: Text(
                          day,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppColors.textSecondary,
                            fontSize: 14,
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
            const SizedBox(height: 16),

            // Date Card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C252B),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Venue Photo Top
                        Expanded(
                          flex: 11,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedNetworkImage(
                                imageUrl: currentPlan['imageUrl'],
                                fit: BoxFit.cover,
                              ),
                              const DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black38,
                                      Colors.transparent,
                                      Colors.black54,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                              // Live Venue badge
                              Positioned(
                                top: 16,
                                left: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.65),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          color: AppColors.onlineGreen,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Live • ${currentPlan['venue']}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Distance badge
                              Positioned(
                                top: 52,
                                left: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Text(
                                    '📍 ${currentPlan['distance']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Date Details Bottom
                        Container(
                          padding: const EdgeInsets.all(20),
                          color: const Color(0xFF2B2329),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Tags row
                              Row(
                                children: [
                                  _buildTag('📅 TODAY', isAccent: true),
                                  const SizedBox(width: 8),
                                  _buildTag('⏰ ${currentPlan['time']}'),
                                  const SizedBox(width: 8),
                                  _buildTag('🍽️ ${currentPlan['type']}'),
                                ],
                              ),
                              const SizedBox(height: 12),

                              // Title & Subtitle
                              Text(
                                currentPlan['title'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                currentPlan['description'],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Badges: Match, Spots, Payment
                              Row(
                                children: [
                                  _buildInfoBadge('💜 ${currentPlan['match']}'),
                                  const SizedBox(width: 8),
                                  _buildInfoBadge('👤 ${currentPlan['spots']}'),
                                  const SizedBox(width: 8),
                                  _buildInfoBadge(
                                      '💳 ${currentPlan['payment']}'),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // User Profile Footer
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              currentPlan['userAvatar']),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '${currentPlan['userName']}, ${currentPlan['userAge']}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              const Icon(Icons.check_circle,
                                                  color: AppColors.primary,
                                                  size: 14),
                                            ],
                                          ),
                                          Text(
                                            currentPlan['userPronouns'],
                                            style: const TextStyle(
                                              color: Colors.white60,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Text(
                                        'Profile →',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Action Buttons: Skip and Request Date
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  // Skip button
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _cardIndex++;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: AppColors.divider),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.close_rounded,
                              color: AppColors.textDark, size: 20),
                          SizedBox(width: 6),
                          Text(
                            'Skip',
                            style: TextStyle(
                              color: AppColors.textDark,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Request Date button
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Date request sent to ${currentPlan['userName']}! 🎉'),
                            backgroundColor: AppColors.primary,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                        setState(() {
                          _cardIndex++;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_today_rounded,
                              color: Colors.white, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Request Date',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, {bool isAccent = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isAccent
            ? AppColors.primary.withValues(alpha: 0.2)
            : Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isAccent ? AppColors.primaryLight : Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildInfoBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
