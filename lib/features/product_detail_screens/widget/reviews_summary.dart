import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

import 'package:slanh_pet_application/core/models/commerce/product.dart';

class ReviewsSummary extends StatelessWidget {
  const ReviewsSummary({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          const Icon(Icons.star_rounded, size: 28, color: Color(0xFFFFB800)),
          const SizedBox(height: 6),
          Text(
            '${product.rating} out of 5',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          Text(
            'Based on ${product.reviewCount} reviews',
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: AppColors.subtitleGray,
            ),
          ),
        ],
      ),
    );
  }
}
