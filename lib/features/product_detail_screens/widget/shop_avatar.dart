import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

class ShopAvatar extends StatelessWidget {
  const ShopAvatar({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: AppColors.orange.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        image: imageUrl.isEmpty
            ? null
            : DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
      ),
      child: imageUrl.isEmpty
          ? const Icon(
              Icons.storefront_rounded,
              size: 18,
              color: AppColors.orange,
            )
          : null,
    );
  }
}
