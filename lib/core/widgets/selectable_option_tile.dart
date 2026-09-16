import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

/// A single selectable row styled like a radio option: an icon, a label,
/// and a filled border/background when selected. Used for payment method,
/// delivery option, and similar single-choice pickers.
class SelectableOptionTile extends StatelessWidget {
  const SelectableOptionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.orange : AppColors.borderLight,
            width: selected ? 2 : 1,
          ),
          color: selected ? AppColors.orange.withValues(alpha: 0.06) : null,
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              size: 20,
              color: selected ? AppColors.orange : AppColors.borderLight,
            ),
            const SizedBox(width: 12),
            Icon(icon, size: 20, color: AppColors.orange),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
