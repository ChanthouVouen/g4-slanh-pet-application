import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

import '../models/product_models.dart';

/// Row showing the seller's avatar, name, rating and follower count.
class StoreInfoRow extends StatelessWidget {
  const StoreInfoRow({super.key, required this.store, required this.onTap});

  final ProductStore store;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.orange.withValues(alpha: 0.12),
              child: const Icon(
                Icons.storefront_rounded,
                color: AppColors.orange,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                store.name,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ),
            const Icon(Icons.star_rounded, size: 15, color: Color(0xFFFFB800)),
            const SizedBox(width: 2),
            Text(
              '${store.rating} · ${store.followers}',
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: AppColors.subtitleGray,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.chevron_right_rounded,
              size: 18,
              color: AppColors.subtitleGray,
            ),
          ],
        ),
      ),
    );
  }
}
