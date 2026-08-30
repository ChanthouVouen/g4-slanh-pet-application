import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

class ClinicCardSummary extends StatelessWidget {
  const ClinicCardSummary({
    super.key,
    required this.name,
    required this.picture,
    required this.address,
    required this.price,
  });
  final String name;
  final String picture;
  final String address;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              // widget.service.imageUrl,
              picture,
              width: 52,
              height: 52,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 52,
                height: 52,
                color: AppColors.inputBackground,
                child: const Icon(Icons.pets, color: AppColors.labelGray),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Price:  $price | $address",
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
