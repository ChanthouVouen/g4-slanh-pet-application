import 'package:flutter/material.dart';

import 'package:slanh_pet_application/core/constants/flash_screen/flash_screen_string.dart';
import 'package:slanh_pet_application/features/onboarding_screen/onbording_screen.dart';
import 'package:slanh_pet_application/core/widgets/slanh_pet_logo.dart';
import 'package:slanh_pet_application/core/widgets/decorative_circle.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  static const Color orange = Color(0xFFFF663C);

  @override
  void initState() {
    super.initState();

    _decideNextScreen();
  }

  Future<void> _decideNextScreen() async {
    final minDelay = Future<void>.delayed(const Duration(milliseconds: 3500));

    await minDelay;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return const OnboardingScreen();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: orange,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              top: 55,
              left: 38,
              child: DecorativeCircle(size: 76, color: orange),
            ),

            const Positioned(
              top: -58,
              right: -72,
              child: DecorativeCircle(size: 190, color: orange),
            ),

            const Positioned(
              left: -56,
              bottom: -38,
              child: DecorativeCircle(size: 198, color: orange),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SlanhPetLogo(),
                    const SizedBox(height: 32),

                    const Text(
                      FlashScreenString.appName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1,
                        letterSpacing: -0.8,
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      FlashScreenString.tagline,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withAlpha(235),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 62),

                    // const SplashIndicator(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
