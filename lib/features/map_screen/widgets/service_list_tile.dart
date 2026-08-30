import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

import '../models/service_location.dart';

/// One row in the services bottom sheet, with a shortcut to get directions.
class ServiceListTile extends StatelessWidget {
  const ServiceListTile({
    super.key,
    required this.location,
    required this.distanceKm,
    required this.onTap,
    required this.onDirections,
  });

  final ServiceLocation location;

  /// Distance from the user's current position, or null while it's unknown.
  final double? distanceKm;
  final VoidCallback onTap;
  final VoidCallback onDirections;

  static const Color _fillGray = Color(0xFFF5F6F8);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _fillGray,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              _Thumbnail(location: location),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (location.address.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        location.address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.labelGray,
                        ),
                      ),
                    ],
                    if (distanceKm != null) ...[
                      const SizedBox(height: 3),
                      Text(
                        '${distanceKm!.toStringAsFixed(1)} km away',
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.labelGray,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Get directions',
                onPressed: onDirections,
                icon: const Icon(
                  Icons.directions_rounded,
                  color: AppColors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.location});

  final ServiceLocation location;

  @override
  Widget build(BuildContext context) {
    final imageUrl = location.imageUrl;
    return Container(
      width: 48,
      height: 48,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFFCE4E1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: imageUrl == null || imageUrl.isEmpty
          ? _fallbackIcon()
          : Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _fallbackIcon(),
            ),
    );
  }

  Widget _fallbackIcon() {
    return const Icon(
      Icons.medical_services_rounded,
      color: AppColors.darkPurple,
      size: 22,
    );
  }
}
