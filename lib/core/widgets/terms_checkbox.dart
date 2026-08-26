import "package:flutter/material.dart";
import "package:slanh_pet_application/core/constants/app_colors.dart";
import "package:slanh_pet_application/core/constants/register/register_string.dart";

class TermsCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const TermsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: const BorderSide(color: AppColors.black, width: 1.5),
          ),
        ),
        const SizedBox(width: 8),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              RegisterString.termsAgreePrefix,
              style: TextStyle(fontSize: 11, color: AppColors.textMuted),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                RegisterString.termsOfService,
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Text(
              RegisterString.termsAnd,
              style: TextStyle(fontSize: 11, color: AppColors.textMuted),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                RegisterString.privacyPolicy,
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
