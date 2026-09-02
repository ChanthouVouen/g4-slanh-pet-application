import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/features/order_booking/models/order_item_model.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order, this.onTrackPackage});

  final OrderItemModel order;
  final VoidCallback? onTrackPackage;

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

  String _formatDate(DateTime date) =>
      '${date.day} ${_months[date.month - 1]} ${date.year}';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: order.iconBackground,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(order.icon, color: order.iconColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.code,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.labelGray,
                      ),
                    ),
                    const SizedBox(height: 3),

                    Text(
                      order.title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 2),

                    Text(
                      "${order.clinicName} | ${order.clinicAddress}",
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.labelGray,
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                ),
              ),
              Text(
                order.status,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                " ${_formatDate(order.date)} | (${order.time})",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.labelGray,
                ),
              ),
              const Spacer(),

              Text(
                '\$${order.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
