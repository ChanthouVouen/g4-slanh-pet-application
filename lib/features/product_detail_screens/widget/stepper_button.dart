import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

class StepperButton extends StatelessWidget {
  const StepperButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.filled = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: filled ? AppColors.orange : Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 30,
          height: 30,
          child: Icon(
            icon,
            size: 16,
            color: filled ? Colors.white : AppColors.black,
          ),
        ),
      ),
    );
  }
}
