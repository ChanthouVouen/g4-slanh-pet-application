import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

import '../models/service_location.dart';
import 'service_list_tile.dart';

/// Draggable bottom sheet listing the services currently visible on the map.
class ServicesSheet extends StatelessWidget {
  const ServicesSheet({
    super.key,
    required this.scrollController,
    required this.locations,
    required this.isLoading,
    required this.distanceKmFor,
    required this.onLocationTap,
    required this.onDirections,
  });

  final ScrollController scrollController;
  final List<ServiceLocation> locations;
  final bool isLoading;

  /// Distance to a location, in km — null while it's still unknown.
  final double? Function(ServiceLocation location) distanceKmFor;
  final ValueChanged<ServiceLocation> onLocationTap;
  final ValueChanged<ServiceLocation> onDirections;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E4EA),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '${locations.length} clinics nearby',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (locations.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Text(
                'No matches found. Try a different search.',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.labelGray,
                ),
              ),
            ),
          for (final location in locations) ...[
            ServiceListTile(
              location: location,
              distanceKm: distanceKmFor(location),
              onTap: () => onLocationTap(location),
              onDirections: () => onDirections(location),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
