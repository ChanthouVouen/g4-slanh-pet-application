import 'package:flutter/material.dart';

import '../models/service_category.dart';

/// A single icon + label shortcut used in the [ServiceCategoryGrid].
class ServiceCategoryTile extends StatelessWidget {
  const ServiceCategoryTile({super.key, required this.category, this.onTap});

  final ServiceCategory category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: category.backgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(category.icon, color: category.iconColor, size: 26),
          ),
          const SizedBox(height: 6),
          Text(
            category.label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
