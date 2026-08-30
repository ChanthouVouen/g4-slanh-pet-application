import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

class CustomGenderDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;
  final List<String> genders;

  const CustomGenderDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.genders = const ['Male', 'Female', 'Other'],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gender',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) => Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.inputBackground.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  isExpanded: true,
                  menuWidth: constraints.maxWidth,
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: AppColors.whiteColor,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textSecondary,
                  ),
                  hint: const Text(
                    'Select gender',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  style: const TextStyle(fontSize: 12, color: AppColors.black),
                  items: genders
                      .map(
                        (gender) => DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        ),
                      )
                      .toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
