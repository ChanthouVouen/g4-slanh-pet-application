import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

extension InputDecorationFillStyle on InputDecoration {
  /// Applies the app's shared rounded, filled look to a text field —
  /// a soft gray background with no visible border in any state.
  InputDecoration applyFillStyle() {
    const noBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide.none,
    );

    return copyWith(
      filled: true,
      fillColor: AppColors.inputBackground.withValues(alpha: 0.6),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: const TextStyle(fontSize: 13, color: AppColors.labelGray),
      border: noBorder,
      enabledBorder: noBorder,
      focusedBorder: noBorder,
      errorBorder: noBorder,
      focusedErrorBorder: noBorder,
      disabledBorder: noBorder,
    );
  }
}
