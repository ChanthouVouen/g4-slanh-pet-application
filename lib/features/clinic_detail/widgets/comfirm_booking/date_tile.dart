import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

import '../selectable_pill_decoration.dart';

class DateTile extends StatelessWidget {
  final String dayName;
  final String dayNumber;
  final bool isSelected;
  final VoidCallback onTap;

  const DateTile({
    super.key,
    required this.dayName,
    required this.dayNumber,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: selectablePillDecoration(isSelected),
        child: Column(
          children: [
            Text(
              dayName,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              dayNumber,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isSelected ? AppColors.primary : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
