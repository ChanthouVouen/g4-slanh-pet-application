import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/features/services/models/service_model.dart';

class ClinicCard extends StatelessWidget {
  const ClinicCard({super.key, required this.service, required this.onTap});

  final ServiceModel service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Thumbnail(service: service),
              const SizedBox(height: 12),
              Text(
                service.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'sfd',
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.labelGray,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    size: 16,
                    color: Color(0xFFFFB800),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    "${service.rating}",
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.location_on_rounded,
                    size: 14,
                    color: AppColors.labelGray,
                  ),
                  Text(
                    '1km',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.labelGray,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Price: ${service.price}\$',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: AppColors.orange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.service});

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(service.picture),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
      ],
    );
  }
}
