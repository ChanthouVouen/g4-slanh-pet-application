import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/constants/register/register_string.dart';

class RegisterFooter extends StatelessWidget {
  final VoidCallback onTapSignIn;

  const RegisterFooter({super.key, required this.onTapSignIn});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTapSignIn,
        child: RichText(
          text: const TextSpan(
            text: RegisterString.alreadyHaveAccount,
            style: TextStyle(fontSize: 13, color: AppColors.textMuted),
            children: [
              TextSpan(
                text: RegisterString.signInAction,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
