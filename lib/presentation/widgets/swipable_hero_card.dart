import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/user_profile.dart';
import 'like_nope_stamps.dart';

class SwipableHeroCard extends StatefulWidget {
  final UserProfile user;
  final bool canUndo;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback onUndo;
  final VoidCallback onRoseTap;
  final double? height;

  const SwipableHeroCard({
    super.key,
    required this.user,
    required this.canUndo,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    required this.onUndo,
    required this.onRoseTap,
    this.height,
  });

  @override
  State<SwipableHeroCard> createState() => _SwipableHeroCardState();
}

class _SwipableHeroCardState extends State<SwipableHeroCard>
    with SingleTickerProviderStateMixin {
  Offset _dragOffset = Offset.zero;
  late AnimationController _animController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset = Offset(_dragOffset.dx + details.delta.dx, 0);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final threshold = screenWidth * 0.35;
    final velocity = details.velocity.pixelsPerSecond.dx;

    if (_dragOffset.dx > threshold || velocity > 800) {
      _animateOut(const Offset(600, 0), widget.onSwipeRight);
    } else if (_dragOffset.dx < -threshold || velocity < -800) {
      _animateOut(const Offset(-600, 0), widget.onSwipeLeft);
    } else {
      _resetPosition();
    }
  }

  void _animateOut(Offset target, VoidCallback onCompleted) {
    _slideAnimation = Tween<Offset>(
      begin: _dragOffset,
      end: target,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));

    _animController.forward(from: 0).then((_) {
      onCompleted();
      _dragOffset = Offset.zero;
      _animController.reset();
    });
  }

  void _resetPosition() {
    _slideAnimation = Tween<Offset>(
      begin: _dragOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutBack,
    ));

    _animController.addListener(() {
      setState(() {
        _dragOffset = _slideAnimation.value;
      });
    });

    _animController.forward(from: 0).then((_) {
      _animController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double dragProgress =
        (_dragOffset.dx / (screenWidth * 0.4)).clamp(-1.0, 1.0);
    final double rotation = (_dragOffset.dx / screenWidth) * (pi / 12);

    final likeOpacity = dragProgress > 0 ? dragProgress : 0.0;
    final nopeOpacity = dragProgress < 0 ? -dragProgress : 0.0;

    return Transform.translate(
      offset: _dragOffset,
      child: Transform.rotate(
        angle: rotation,
        child: GestureDetector(
          onHorizontalDragUpdate: _onHorizontalDragUpdate,
          onHorizontalDragEnd: _onHorizontalDragEnd,
          child: Container(
            height: widget.height ?? 580,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.10),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Profile Photo
                  CachedNetworkImage(
                    imageUrl: widget.user.primaryImageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: const Color(0xFFE5E2DC),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                          strokeWidth: 2.5,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: const Color(0xFF2C2C2E),
                      child: const Icon(Icons.person,
                          size: 80, color: Colors.white54),
                    ),
                  ),

                  // Gradient Overlay for Text Readability
                  const Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: AppColors.cardOverlayGradient,
                      ),
                    ),
                  ),

                  // LIKE Stamp Overlay
                  Positioned(
                    top: 36,
                    right: 20,
                    child: LikeStamp(opacity: likeOpacity),
                  ),

                  // NOPE Stamp Overlay
                  Positioned(
                    top: 36,
                    left: 20,
                    child: NopeStamp(opacity: nopeOpacity),
                  ),

                  // Top Action Buttons (Undo and Options)
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Rewind / Undo Button
                        _buildFrostedIconButton(
                          icon: Icons.replay_rounded,
                          onTap: widget.canUndo ? widget.onUndo : () {},
                          isEnabled: widget.canUndo,
                        ),
                        // 3-dots Menu Button
                        _buildFrostedIconButton(
                          icon: Icons.more_vert_rounded,
                          onTap: () {},
                          isEnabled: true,
                        ),
                      ],
                    ),
                  ),

                  // Bottom Content Details on Hero Card
                  Positioned(
                    bottom: 18,
                    left: 18,
                    right: 18,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Match % and Trust Pills
                        Row(
                          children: [
                            _buildColoredDotPill(const Color(0xFF3B82F6),
                                '${widget.user.matchPercentage}% Match'),
                            const SizedBox(width: 8),
                            _buildColoredDotPill(const Color(0xFF10B981),
                                '${widget.user.trustPercentage}% Trust'),
                            const SizedBox(width: 8),
                            _buildColoredDotPill(const Color(0xFFF59E0B),
                                widget.user.replyTime),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Name, Age, Online & Verified Badges
                        Row(
                          children: [
                            if (widget.user.isOnline) ...[
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF22C55E),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                            Flexible(
                              child: Text(
                                '${widget.user.name}  ${widget.user.age}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (widget.user.isVerified)
                              Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE93E63),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.check,
                                    size: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),

                        // Location
                        Row(
                          children: [
                            const Icon(Icons.location_on_rounded,
                                size: 14, color: Colors.white),
                            const SizedBox(width: 6),
                            Text(
                              '${widget.user.city} • ${widget.user.distanceKm} km away',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),

                        // Profession
                        Row(
                          children: [
                            const Icon(Icons.work_outline_rounded,
                                size: 14, color: Colors.white),
                            const SizedBox(width: 6),
                            Text(
                              widget.user.profession,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),

                        // Relationship Goal
                        Row(
                          children: [
                            const Icon(Icons.favorite_rounded,
                                size: 13, color: Colors.white),
                            const SizedBox(width: 6),
                            Text(
                              widget.user.relationshipGoal,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Bottom Right Floating Rose Button with Glowing Aura
                  Positioned(
                    bottom: 20,
                    right: 18,
                    child: GestureDetector(
                      onTap: widget.onRoseTap,
                      child: Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFE93E63)
                                  .withValues(alpha: 0.45),
                              blurRadius: 18,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            '🌹',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColoredDotPill(Color dotColor, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0x99181A20),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFrostedIconButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isEnabled,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isEnabled
              ? Colors.white
              : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: isEnabled ? 0.25 : 0.1),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: Colors.black,
          size: 20,
        ),
      ),
    );
  }
}
