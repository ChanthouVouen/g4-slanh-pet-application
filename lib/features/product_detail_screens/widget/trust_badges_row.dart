import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

/// The "Free Delivery / Easy Returns / Authentic" trust row at the bottom
/// of the product card.
class TrustBadgesRow extends StatelessWidget {
  const TrustBadgesRow({super.key});

  static const _badges = [
    _Badge(icon: Icons.local_shipping_rounded, label: 'Free Delivery', color: Color(0xFF2F80ED)),
    _Badge(icon: Icons.replay_rounded, label: 'Easy Returns', color: Color(0xFF2F80ED)),
    _Badge(icon: Icons.verified_rounded, label: 'Authentic', color: AppColors.success),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [for (final badge in _badges) _TrustBadgeItem(badge: badge)],
    );
  }
}

class _Badge {
  const _Badge({required this.icon, required this.label, required this.color});

  final IconData icon;
  final String label;
  final Color color;
}

class _TrustBadgeItem extends StatelessWidget {
  const _TrustBadgeItem({required this.badge});

  final _Badge badge;

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
