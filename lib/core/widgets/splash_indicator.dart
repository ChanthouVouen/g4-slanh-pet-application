import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SplashIndicator extends StatelessWidget {
  const SplashIndicator({
    super.key,
    this.currentPage = 0,
    this.pageCount = 3,
  });

  final int currentPage;
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(pageCount, (index) {
        final isActive = index == currentPage;
        return Padding(
          padding: EdgeInsets.only(right: index == pageCount - 1 ? 0 : 8),
          child: isActive ? const _SplashBar() : const SplashDot(),
        );
      }),
    );
  }
}

class _SplashBar extends StatelessWidget {
  const _SplashBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 6,
      decoration: BoxDecoration(
        color: AppColors.orange,
        borderRadius: BorderRadius.circular(100),
      ),
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
