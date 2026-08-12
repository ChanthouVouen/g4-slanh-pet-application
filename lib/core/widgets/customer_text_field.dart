import 'package:flutter/material.dart';
import "package:slanh_pet_application/core/constants/app_colors.dart";
import 'package:slanh_pet_application/core/widgets/field_label.dart';
import 'package:slanh_pet_application/core/widgets/input_decoration_extensions.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool? isObscure;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FieldLabel(label),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: controller,
            obscureText: isObscure ?? false,
            keyboardType: keyboardType,
            autocorrect: false,
            validator: validator,
            style: const TextStyle(fontSize: 14, color: AppColors.black),
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
            ).applyFillStyle(),
          ),
        ],
      ),
    );
  }
}
