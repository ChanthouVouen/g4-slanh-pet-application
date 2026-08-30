import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

BoxDecoration selectablePillDecoration(bool isSelected) {
  return BoxDecoration(
    color: isSelected ? const Color(0xFFFFF0EB) : Colors.white,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: isSelected ? AppColors.primary : Colors.transparent,
      width: 1.5,
    ),
  );
}
