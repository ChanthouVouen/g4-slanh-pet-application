import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

class LoginFooter extends StatelessWidget {
  final VoidCallback onTapSignUp;

  const LoginFooter({super.key, required this.onTapSignUp});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w500,
            color: AppColors.subtitleGray,
          ),
          children: [
            const TextSpan(text: "Don't have an account? "),
            TextSpan(
              text: 'Sign Up',
              style: const TextStyle(
                color: AppColors.orange,
                fontWeight: FontWeight.w800,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTapSignUp,
            ),
          ],
        ),
      ),
    );
  }
}
