import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

import 'package:slanh_pet_application/core/models/commerce/product.dart';
import 'dot.dart';

class RatingRow extends StatelessWidget {
  const RatingRow({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star_rounded, size: 17, color: Color(0xFFFFB800)),
        const SizedBox(width: 3),
        Text(
          '${product.rating}',
          style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
        ),
        const SizedBox(width: 8),
        const Dot(),
        const SizedBox(width: 8),
        Text(
          '${_formatCount(product.soldCount)} sold',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.subtitleGray,
          ),
        ),
        const SizedBox(width: 8),
        const Dot(),
        const SizedBox(width: 8),
        Text(
          '${product.reviewCount} reviews',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.subtitleGray,
          ),
        ),
      ],
    );
  }

  static String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(count % 1000 == 0 ? 0 : 1)}k';
    }
    return count.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => ',',
    );
  }
}
