import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/features/auth/login/login.dart';
import 'package:slanh_pet_application/features/onboarding_screen/data/models/onboarding_model.dart';
import 'package:slanh_pet_application/features/onboarding_screen/widgets/onboarding_bottom_controls.dart';
import 'package:slanh_pet_application/features/onboarding_screen/widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const List<OnboardingModel> _pages = [
    OnboardingModel(
      imagePath: 'assets/images/onboarding_shop.jpg',
      title: 'Everything For Your\nPet',
      description:
          'Shop premium food, toys and accessories\n'
          'from trusted brands worldwide.',
    ),
    OnboardingModel(
      imagePath: 'assets/images/onboarding_care.jpg',
      title: 'Professional Pet\nCare',
      description:
          'Book vet appointments, grooming, training\n'
          'and hotel stays in seconds.',
    ),
    OnboardingModel(
      imagePath: 'assets/images/onboarding_partner.jpg',
      title: 'Find Your Pet\nPartner',
      description:
          'Adopt or buy pets from verified breeders\n'
          'near you with full health records.',
    ),
  ];

  bool get _isLastPage => _currentPage == _pages.length - 1;

  void _nextPage() {
    if (_isLastPage) {
      _finishOnboarding();
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 360),
      curve: Curves.easeOutCubic,
    );
  }

  void _skipOnboarding() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
    );
  }

  void _finishOnboarding() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (context) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (page) => setState(() => _currentPage = page),
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    data: _pages[index],
                    currentPage: _currentPage,
                    pageCount: _pages.length,
                  );
                },
              ),
            ),
            OnboardingBottomControls(
              isLastPage: _isLastPage,
              onSkip: _skipOnboarding,
              onNext: _nextPage,
            ),
          ],
        ),
      ),
    );
  }
}
