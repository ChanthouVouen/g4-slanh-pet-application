import 'package:flutter/material.dart';
import 'package:slanh_pet_application/features/market_screen/widget/categories_part/categories_detail.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String selectedCategory = "All";

  final List<String> categories = [
    "All",
    "Food",
    "Grooming",
    "Toys",
    "Accessories",
    "Health",
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

              // Is this category selected?
              isSelected: selectedCategory == category,

              // When user taps
              onTap: () {
                setState(() {
                  selectedCategory = category;
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
