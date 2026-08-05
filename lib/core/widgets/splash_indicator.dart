import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SplashIndicator extends StatelessWidget {
  const SplashIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 6,
          decoration: BoxDecoration(
            color: AppColors.indicatorActive,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        const SizedBox(width: 8),
        const SplashDot(),
        const SizedBox(width: 8),
        const SplashDot(),
      ],
    );
  }
}

class SplashDot extends StatelessWidget {
  const SplashDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7,
      height: 7,
      decoration: const BoxDecoration(
        color: AppColors.indicatorInactive,
        shape: BoxShape.circle,
      ),
    );
  }
}
