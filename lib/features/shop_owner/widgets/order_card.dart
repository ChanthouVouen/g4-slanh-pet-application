import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/models/orders/shop_order.dart';
import 'package:slanh_pet_application/core/widgets/status_pill.dart';

class ShopOrderCard extends StatelessWidget {
  const ShopOrderCard({super.key, required this.order});

  final ShopOrder order;

  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day} ${_months[date.month - 1]} ${date.year}';
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return const Color(0xFF3DA35D);
      case 'cancelled':
        return const Color(0xFFE5484D);
      case 'shipped':
      case 'processing':
        return const Color(0xFF4B8CE0);
      default:
        return const Color(0xFFE8A33D);
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemsLabel = order.items
        .map(
          (item) =>
              item.quantity > 1 ? '${item.name} x${item.quantity}' : item.name,
        )
        .join(', ');
    final statusColor = _statusColor(order.status);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.customerName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      itemsLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '\$${order.subtotal.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppColors.orange,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.orderRef.isEmpty
                    ? _formatDate(order.createdAt)
                    : '${order.orderRef} · ${_formatDate(order.createdAt)}',
                style: const TextStyle(
                  fontSize: 11.5,
                  color: AppColors.labelGray,
                  fontWeight: FontWeight.w600,
                ),
              ),
              StatusPill(
                label: order.status,
                background: statusColor.withValues(alpha: 0.14),
                foreground: statusColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
