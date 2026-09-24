import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../pages/home/compliment_ideas_page.dart';

class ComplimentBottomSheet extends StatefulWidget {
  final String title;
  final String? initialText;
  final Function(String compliment, String giftType) onSend;

  const ComplimentBottomSheet({
    super.key,
    required this.title,
    this.initialText,
    required this.onSend,
  });

  @override
  State<ComplimentBottomSheet> createState() => _ComplimentBottomSheetState();
}

class _ComplimentBottomSheetState extends State<ComplimentBottomSheet> {
  late TextEditingController _textController;
  String _selectedGift = 'Rose';
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialText ?? '');
    _textController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _openIdeas() async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (context) => const ComplimentIdeasPage(),
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        _textController.text = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasText = _textController.text.trim().isNotEmpty;
    final int charCount = _textController.text.length;

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 14,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Complimenting Title
          const Text(
            'COMPLIMENTING',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            widget.title,
            style: const TextStyle(
              color: AppColors.textDark,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),

          // Stats row
          Row(
            children: [
              _buildStatItem('💬 3 comments'),
              const SizedBox(width: 14),
              _buildStatItem('🌹 2 roses'),
              const SizedBox(width: 14),
              _buildStatItem('🪙 5,258 balance', isGold: true),
            ],
          ),
          const SizedBox(height: 16),

          // Input field container
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        maxLines: 3,
                        maxLength: 140,
                        style: const TextStyle(
                          color: AppColors.textDark,
                          fontSize: 15,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Write a sweet compliment...',
                          hintStyle: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          counterText: '',
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _openIdeas,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.divider),
                        ),
                        child: const Row(
                          children: [
                            Text('💡', style: TextStyle(fontSize: 14)),
                            SizedBox(width: 4),
                            Text(
                              'Try',
                              style: TextStyle(
                                color: AppColors.textDark,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Gift selection chips + Character counter
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildGiftChip('🌹 Rose', isSelected: _selectedGift == 'Rose'),
                  const SizedBox(width: 10),
                  _buildGiftChip('🎁 Select Gift',
                      isSelected: _selectedGift == 'Gift'),
                ],
              ),
              Text(
                '$charCount/140',
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Action buttons: Like and Send
          Row(
            children: [
              // Like Button
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isLiked = !_isLiked;
                  });
                },
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(
                      color: _isLiked ? AppColors.primary : AppColors.divider,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isLiked
                            ? Icons.favorite_rounded
                            : Icons.favorite_outline_rounded,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Like',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Send Button
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    final textToSend = hasText
                        ? _textController.text.trim()
                        : 'Sent a rose!';
                    Navigator.of(context).pop();
                    widget.onSend(textToSend, _selectedGift);
                  },
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: hasText
                          ? AppColors.primaryGradient
                          : LinearGradient(
                              colors: [
                                AppColors.primary.withValues(alpha: 0.3),
                                AppColors.primaryDark.withValues(alpha: 0.3),
                              ],
                            ),
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: hasText
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            hasText ? 'Send 🌹 + 💬' : 'Send Compliment',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String text, {bool isGold = false}) {
    return Text(
      text,
      style: TextStyle(
        color: isGold ? AppColors.goldCoin : AppColors.textSecondary,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildGiftChip(String text, {required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGift = text.contains('Rose') ? 'Rose' : 'Gift';
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primarySoft : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: 1.2,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.textDark,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
