import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

class LocationRatingWidget extends StatelessWidget {
  const LocationRatingWidget({
    super.key,
    required this.rating,
    required this.address,
  });

  final double rating;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 18),
        const SizedBox(width: 4),
        Text(
          "$rating",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        const Text('  •  ', style: TextStyle(color: AppColors.textSecondary)),
        Text(
          address,
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        const Icon(
          Icons.location_on_outlined,
          color: AppColors.textSecondary,
          size: 16,
        ),
        const SizedBox(width: 2),
        Expanded(
          child: Text(
            '12 km',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
