import 'package:flutter/material.dart';

class AppSearchField extends StatelessWidget {
  const AppSearchField({super.key, required this.hintText, this.onChanged});

  final String hintText;
  final ValueChanged<String>? onChanged;

  static const Color _hintGray = Color(0xFF9AA5B1);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: _hintGray,
            fontWeight: FontWeight.w500,
            fontSize: 14.5,
          ),

          prefixIcon: const Icon(
            Icons.search_rounded,
            color: _hintGray,
            size: 20,
          ),

          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
