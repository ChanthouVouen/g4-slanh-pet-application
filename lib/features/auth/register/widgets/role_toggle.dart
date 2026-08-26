import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/register/register_string.dart';

class RoleToggle extends StatelessWidget {
  final bool isCustomer;
  final ValueChanged<bool> onChanged;

  const RoleToggle({
    super.key,
    required this.isCustomer,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFEFECE6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          _buildSegment(
            RegisterString.roleCustomer,
            isCustomer,
            () => onChanged(true),
          ),
          _buildSegment(
            RegisterString.roleSeller,
            !isCustomer,
            () => onChanged(false),
          ),
        ],
      ),
    );
  }

  Widget _buildSegment(String title, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? AppColors.orange : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
