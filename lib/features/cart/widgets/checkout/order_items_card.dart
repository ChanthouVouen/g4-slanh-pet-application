import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/widgets/section_card.dart';

import '../../cart_store.dart';

class OrderItemsCard extends StatelessWidget {
  const OrderItemsCard({super.key, required this.items, required this.total});

  final List<CartProduct> items;
  final double total;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      children: [
        SectionHeader(Icons.shopping_bag_outlined, 'Order Items (${items.length})'),
        const SizedBox(height: 12),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item.quantity > 1
                        ? '${item.name} (x${item.quantity})'
                        : item.name,
                    style: const TextStyle(color: AppColors.textSecondary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        const Divider(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total', style: TextStyle(fontWeight: FontWeight.w700)),
            Text(
              '\$${total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: AppColors.orange,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
