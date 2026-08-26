import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/widgets/splash_indicator.dart';
import 'package:slanh_pet_application/features/onboarding_screen/data/models/onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.data,
    required this.currentPage,
    required this.pageCount,
  });

  final OnboardingModel data;
  final int currentPage;
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: AspectRatio(
              aspectRatio: 4 / 3.2,
              child: Image.asset(
                data.imagePath,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),

          const SizedBox(height: 28),

          SplashIndicator(currentPage: currentPage, pageCount: pageCount),

          const SizedBox(height: 24),

          Text(
            data.title,
            style: const TextStyle(
              color: AppColors.darkPurple,
              fontSize: 28,
              fontWeight: FontWeight.w800,
              height: 1.2,
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            data.description,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              height: 1.6,
            ),
          ),

          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
