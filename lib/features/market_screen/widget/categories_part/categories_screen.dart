import 'package:flutter/material.dart';
import 'package:slanh_pet_application/features/market_screen/widget/categories_part/categories_detail.dart';

class CategoriesScreen extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoriesScreen({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final List<String> categories = const [
    "All",
    "Food",
    "Toy",
    "Accessories",
    "Pets",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            return CategoriesDetail(
              name: category,

              // Check which category is selected
              isSelected: selectedCategory == category,

              // Tell parent which category was clicked
              onTap: () {
                onCategorySelected(category);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
