import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

import 'package:slanh_pet_application/core/models/commerce/product.dart';
import 'reviews_summary.dart';
import 'spec_grid.dart';

class TabContent extends StatelessWidget {
  const TabContent({super.key, required this.product, required this.tabIndex});

  final Product product;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    switch (tabIndex) {
      case 1:
        return SpecGrid(specs: product.nutrition);
      case 2:
        return ReviewsSummary(product: product);
      case 0:
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            SpecGrid(specs: product.details),
          ],
        );
    }
  }
}
