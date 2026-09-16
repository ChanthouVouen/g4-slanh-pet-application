import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'shop_avatar.dart';

/// Greyed-out stand-in with the same height as the real row, so the card
/// doesn't jump once the shop document arrives. When [reason] is set the
/// lookup finished with nothing to show; debug builds print it here so the
/// cause is visible without digging through the console. Release builds
/// always show the plain placeholder.
class StoreRowSkeleton extends StatelessWidget {
  const StoreRowSkeleton({super.key, required this.reason});

  final String? reason;

  @override
  Widget build(BuildContext context) {
    if (reason != null && kDebugMode) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShopAvatar(imageUrl: ''),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Shop not shown — $reason',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        const ShopAvatar(imageUrl: ''),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bar(width: 120, height: 11),
              const SizedBox(height: 6),
              _bar(width: 80, height: 9),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bar({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
