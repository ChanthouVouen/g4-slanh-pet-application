import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/widgets/section_card.dart';

import 'package:slanh_pet_application/core/models/orders/delivery_address.dart';

class DeliveryAddressCard extends StatelessWidget {
  const DeliveryAddressCard({
    super.key,
    required this.address,
    required this.loading,
    required this.onChangeTap,
  });

  final DeliveryAddress address;
  final bool loading;
  final VoidCallback onChangeTap;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      children: [
        SectionHeader(
          Icons.location_on_outlined,
          'Delivery Address',
          trailing: TextButton(
            onPressed: onChangeTap,
            child: const Text(
              'Change',
              style: TextStyle(
                color: AppColors.orange,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (loading)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: LinearProgressIndicator(),
          )
        else if (!address.isComplete)
          const Text(
            'No delivery address yet. Tap Change to add one.',
            style: TextStyle(color: AppColors.textSecondary),
          )
        else ...[
          if (address.name.isNotEmpty)
            Text(
              address.name,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
          if (address.phone.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              address.phone,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ],
          const SizedBox(height: 2),
          Text(
            address.address,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ],
    );
  }
}
