import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class LikeStamp extends StatelessWidget {
  final double opacity;

  const LikeStamp({super.key, required this.opacity});

  @override
  Widget build(BuildContext context) {
    if (opacity <= 0.01) return const SizedBox.shrink();

    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: Transform.rotate(
        angle: -15 * pi / 180,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.likeGreen, width: 3.5),
            borderRadius: BorderRadius.circular(12),
            color: Colors.black.withValues(alpha: 0.2),
          ),
          child: const Text(
            'LIKE',
            style: TextStyle(
              color: AppColors.likeGreen,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class NopeStamp extends StatelessWidget {
  final double opacity;

  const NopeStamp({super.key, required this.opacity});

  @override
  Widget build(BuildContext context) {
    if (opacity <= 0.01) return const SizedBox.shrink();

    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: Transform.rotate(
        angle: 15 * pi / 180,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.nopeRed, width: 3.5),
            borderRadius: BorderRadius.circular(12),
            color: Colors.black.withValues(alpha: 0.2),
          ),
          child: const Text(
            'NOPE',
            style: TextStyle(
              color: AppColors.nopeRed,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
