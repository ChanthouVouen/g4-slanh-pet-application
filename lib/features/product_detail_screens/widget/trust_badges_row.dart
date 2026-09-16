import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

import 'trust_badge.dart';
import 'trust_badge_item.dart';

/// The "Free Delivery / Easy Returns / Authentic" trust row at the bottom
/// of the product card.
class TrustBadgesRow extends StatelessWidget {
  const TrustBadgesRow({super.key});

  static const _badges = [
    TrustBadge(
      icon: Icons.local_shipping_rounded,
      label: 'Free Delivery',
      color: Color(0xFF2F80ED),
    ),
    TrustBadge(
      icon: Icons.replay_rounded,
      label: 'Easy Returns',
      color: Color(0xFF2F80ED),
    ),
    TrustBadge(
      icon: Icons.verified_rounded,
      label: 'Authentic',
      color: AppColors.success,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [for (final badge in _badges) TrustBadgeItem(badge: badge)],
    );
  }
}
