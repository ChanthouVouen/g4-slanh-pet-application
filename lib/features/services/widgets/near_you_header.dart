import 'package:flutter/material.dart';

/// "Near You" section title with a filter shortcut.
class NearYouHeader extends StatelessWidget {
  const NearYouHeader({super.key, required this.onFilterTap});

  final VoidCallback onFilterTap;

  static const Color _orange = Color(0xFFFF663C);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Near You',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
        InkWell(
          onTap: onFilterTap,
          borderRadius: BorderRadius.circular(100),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.filter_list_rounded, size: 16, color: _orange),
                SizedBox(width: 4),
                Text(
                  'Filter',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _orange,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
