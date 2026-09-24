import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../domain/entities/user_profile.dart';

class ProfileDetailContent extends StatelessWidget {
  final UserProfile user;
  final Function(String title) onComplimentTap;

  const ProfileDetailContent({
    super.key,
    required this.user,
    required this.onComplimentTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Match & Trust Badges
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildPillStat('• ${user.matchPercentage}% Match'),
              const SizedBox(width: 8),
              _buildPillStat('🛡️ ${user.trustPercentage}% Trust'),
              const SizedBox(width: 8),
              _buildPillStat('⚡ ${user.replyTime}'),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // About
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildAboutSection(),
        ),
        const SizedBox(height: 16),

        // The Basics
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildBasicsSection(),
        ),
        const SizedBox(height: 16),

        // Video Intro
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildVideoIntroCard(),
        ),
        const SizedBox(height: 16),

        // Prompt 1
        if (user.prompts.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildPromptCard(user.prompts[0]),
          ),
          const SizedBox(height: 16),
        ],

        // Career & Ambition
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildCareerSection(),
        ),
        const SizedBox(height: 16),

        // Her Big Dream
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildDreamSection(),
        ),
        const SizedBox(height: 16),

        // Photo 2
        if (user.galleryImages.length > 1) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildGalleryPhoto(user.galleryImages[1], 'Photo'),
          ),
          const SizedBox(height: 16),
        ],

        // Prompt 2
        if (user.prompts.length > 1) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildPromptCard(user.prompts[1]),
          ),
          const SizedBox(height: 16),
        ],

        // Interests & Hobbies
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildInterestsSection(),
        ),
        const SizedBox(height: 16),

        // Lifestyle
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildLifestyleSection(),
        ),
        const SizedBox(height: 16),

        // Dating Goal
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildDatingGoalCard(),
        ),
        const SizedBox(height: 16),

        // Photo 3
        if (user.galleryImages.length > 2) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildGalleryPhoto(user.galleryImages[2], 'Photo'),
          ),
          const SizedBox(height: 16),
        ],

        // Prompt 3
        if (user.prompts.length > 2) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildPromptCard(user.prompts[2]),
          ),
          const SizedBox(height: 20),
        ],
      ],
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ABOUT',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              _buildRoseActionButton('About'),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            user.about,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'THE BASICS',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          _buildBasicRow(Icons.cake_outlined, 'Age',
              '${user.age} years old\n${user.dobFormatted}'),
          _buildBasicRow(Icons.straighten_rounded, 'Height', user.height),
          _buildBasicRow(Icons.location_on_outlined, 'Lives in',
              '${user.city}, ${user.state}'),
          _buildBasicRow(Icons.favorite_outline_rounded, 'Love language',
              'Compliment\n${user.loveLanguage}'),
          _buildBasicRow(Icons.spa_outlined, 'Religion', user.religion),
          _buildBasicRow(Icons.wc_rounded, 'Interested in', user.interestedIn),
          _buildBasicRow(Icons.wb_sunny_outlined, 'Zodiac',
              '${user.zodiac}\n${user.zodiacTraits}'),
          _buildBasicRow(
              Icons.translate_rounded, 'Mother tongue', user.motherTongue),
          _buildBasicRow(Icons.phone_in_talk_outlined, 'Communication style',
              user.communicationStyle),
        ],
      ),
    );
  }

  Widget _buildBasicRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 14),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoIntroCard() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: CachedNetworkImageProvider(user.primaryImageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Container(color: Colors.black38),
            Positioned(
              top: 14,
              left: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.videocam_rounded,
                        color: Colors.white, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'Video intro ${user.videoIntroDuration}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            const Center(
              child: CircleAvatar(
                radius: 26,
                backgroundColor: Colors.white,
                child: Icon(Icons.play_arrow_rounded,
                    color: AppColors.primary, size: 34),
              ),
            ),
            Positioned(
              bottom: 14,
              right: 14,
              child: _buildRoseActionButton('Video intro'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromptCard(ProfilePrompt prompt) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  prompt.question,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              _buildRoseActionButton('Prompt'),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            prompt.answer,
            style: const TextStyle(
              color: AppColors.textDark,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCareerSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CAREER & AMBITION',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          _buildBasicRow(Icons.school_outlined, 'Education', user.education),
          _buildBasicRow(
              Icons.work_outline_rounded, 'Work as', user.profession),
          _buildBasicRow(
              Icons.auto_awesome_outlined, 'Work style', user.workStyle),
          _buildBasicRow(
              Icons.trending_up_rounded, 'Ambition level', user.ambitionLevel),
        ],
      ),
    );
  }

  Widget _buildDreamSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'HER BIG DREAM',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              _buildRoseActionButton('Her Big Dream'),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            user.bigDream,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryPhoto(String url, String title) {
    return Container(
      height: 380,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: _buildRoseActionButton(title),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'INTERESTS & HOBBIES',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              _buildRoseActionButton('Interests & Hobbies'),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 10,
            children: user.hobbies.map((hobby) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Text(
                  hobby,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLifestyleSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LIFESTYLE',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          ...user.lifestyle.entries.map((entry) {
            return _buildBasicRow(
                Icons.circle_outlined, entry.key, entry.value);
          }),
        ],
      ),
    );
  }

  Widget _buildDatingGoalCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.datingGoalGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DATING GOAL',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            user.datingGoalTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            user.datingGoalDescription,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoseActionButton(String title) {
    return GestureDetector(
      onTap: () => onComplimentTap(title),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Center(
          child: Text('🌹', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  Widget _buildPillStat(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.textDark,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
