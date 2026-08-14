import 'package:flutter/material.dart';

import '../models/service_category.dart';
import 'service_category_tile.dart';

/// Fixed 4-column grid of service category shortcuts.
class ServiceCategoryGrid extends StatelessWidget {
  const ServiceCategoryGrid({
    super.key,
    required this.categories,
    this.onCategoryTap,
  });

  final List<ServiceCategory> categories;
  final ValueChanged<ServiceCategory>? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 8,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        return ServiceCategoryTile(
          category: category,
          onTap: onCategoryTap == null ? null : () => onCategoryTap!(category),
        );
      },
    );
  }
}
