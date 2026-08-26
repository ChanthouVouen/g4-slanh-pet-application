import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

/// Circular paw-icon badge shown at the top of auth screens (login, register).
class AuthPawBadge extends StatelessWidget {
  const AuthPawBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.orange.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.pets, color: AppColors.orange, size: 32),
    );
  }
}
