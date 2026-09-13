import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

import 'trust_badge.dart';

class TrustBadgeItem extends StatelessWidget {
  const TrustBadgeItem({super.key, required this.badge});

  final TrustBadge badge;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(badge.icon, size: 20, color: badge.color),
        const SizedBox(height: 4),
        Text(
          badge.label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.subtitleGray,
          ),
        ),
      ],
    );
  }
}
