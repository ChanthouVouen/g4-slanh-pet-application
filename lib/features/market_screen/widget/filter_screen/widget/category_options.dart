import 'package:flutter/material.dart';

class CategoryOptions extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;

  final Color orange;
  final Color greyText;
  final Color lightBorder;

  final ValueChanged<String> onSelected;

  const CategoryOptions({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.orange,
    required this.greyText,
    required this.lightBorder,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 12,
      children: categories.map((category) {
        final isSelected = selectedCategory == category;

        return GestureDetector(
          onTap: () {
            onSelected(category);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
            decoration: BoxDecoration(
              color: isSelected ? orange.withValues(alpha: 0.08) : Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: isSelected ? orange : lightBorder,
                width: isSelected ? 2 : 1.5,
              ),
            ),
            child: Text(
              category,
              style: TextStyle(
                color: isSelected ? orange : greyText,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
