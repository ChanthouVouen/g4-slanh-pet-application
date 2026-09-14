import 'package:flutter/material.dart';

class CategoriesDetail extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoriesDetail({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.deepOrange
              : const Color.fromARGB(125, 233, 233, 233),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? Colors.white
                : const Color.fromARGB(255, 134, 134, 134),
          ),
        ),
      ),
    );
  }
}
