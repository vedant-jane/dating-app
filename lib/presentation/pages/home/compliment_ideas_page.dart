import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ComplimentIdeasPage extends StatefulWidget {
  const ComplimentIdeasPage({super.key});

  @override
  State<ComplimentIdeasPage> createState() => _ComplimentIdeasPageState();
}

class _ComplimentIdeasPageState extends State<ComplimentIdeasPage> {
  String _selectedCategory = 'Flirty';
  String? _selectedCompliment = "If you're as fun in person as your profile, I'm in.";

  final Map<String, List<String>> _ideasByCategory = {
    'Sweet': [
      'Your smile is absolutely contagious 😊',
      'You have the kind of warmth that makes people feel at home.',
      "There's something genuinely lovely about your energy.",
      'I could probably talk to you for hours and never get bored.',
      'You seem like the kind of person who makes ordinary days better.',
      'Your kindness really comes through in your profile.',
    ],
    'Playful': [
      "I'm usually bad at small talk, but you seem worth practicing for.",
      'Are you always this adventurous, or just trying to look cool?',
      'Bet you \$5 I can guess your coffee order in two tries.',
      "If we don't get along, at least we'll have a good debate.",
      'I have a feeling you are the designated chaotic friend in your group.',
    ],
    'Admiring': [
      'I really admire how driven you seem about your work.',
      'Your ambition is honestly inspiring.',
      "It's rare to see someone so genuine in how they present themselves.",
      'You clearly have a great eye for the things you love.',
      'The way you talk about your passions is really attractive.',
      'I respect someone who knows exactly what they want.',
    ],
    'Flirty': [
      'Not gonna lie, your smile stopped my scroll 😍',
      "You're trouble, I can already tell — the good kind.",
      "If you're as fun in person as your profile, I'm in.",
      "I think we'd make a dangerously good team 🤝",
      "You've got a vibe I can't quite look away from.",
      "Coffee, you, and good conversation — when's good for you?",
    ],
    'Funny': [
      'On a scale from 1 to 10, how likely are you to steal my fries?',
      'I see you have great taste in dating profiles.',
      "I was going to say something smooth, but I'll settle for hello 👋",
      'Do you believe in love at first swipe?',
    ],
  };

  void _useCompliment() {
    if (_selectedCompliment == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              'Compliment added',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: Colors.black87,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );

    Navigator.of(context).pop(_selectedCompliment);
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['Sweet', 'Playful', 'Admiring', 'Flirty', 'Funny'];
    final currentIdeas = _ideasByCategory[_selectedCategory] ?? [];

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                children: [
                  // Icon Header
                  Center(
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.chat_bubble_outline_rounded,
                          size: 38,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Header Titles
                  const Center(
                    child: Text(
                      'Compliment Ideas',
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Center(
                    child: Text(
                      'Pick one to make a great first impression',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Category Tabs
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((cat) {
                        final isCatSelected = _selectedCategory == cat;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(cat),
                            selected: isCatSelected,
                            onSelected: (_) {
                              setState(() {
                                _selectedCategory = cat;
                              });
                            },
                            selectedColor: AppColors.primarySoft,
                            backgroundColor: Colors.white,
                            side: BorderSide(
                              color: isCatSelected
                                  ? AppColors.primary
                                  : AppColors.divider,
                              width: 1.2,
                            ),
                            labelStyle: TextStyle(
                              color: isCatSelected
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                              fontWeight: isCatSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              fontSize: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Ideas List
                  ...currentIdeas.map((idea) {
                    final isSelected = _selectedCompliment == idea;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCompliment = idea;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primarySoft
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.divider,
                            width: isSelected ? 1.5 : 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                idea,
                                style: TextStyle(
                                  color: isSelected
                                      ? AppColors.primaryDark
                                      : AppColors.textDark,
                                  fontSize: 15,
                                  height: 1.4,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            if (isSelected)
                              Container(
                                width: 22,
                                height: 22,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Bottom Sticky Button: "Use this compliment"
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _selectedCompliment != null ? _useCompliment : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.3),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: const Text(
                    'Use this compliment',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
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
