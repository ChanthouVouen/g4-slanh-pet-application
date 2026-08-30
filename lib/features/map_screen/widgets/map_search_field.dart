import 'package:flutter/material.dart';

class MapSearchField extends StatelessWidget {
  const MapSearchField({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  static const Color hintGray = Color(0xFF9AA5B1);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500),
        decoration: const InputDecoration(
          hintText: 'Services near Phnom Penh',
          hintStyle: TextStyle(
            color: hintGray,
            fontWeight: FontWeight.w500,
            fontSize: 14.5,
          ),
          prefixIcon: Icon(Icons.search_rounded, color: hintGray, size: 20),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
