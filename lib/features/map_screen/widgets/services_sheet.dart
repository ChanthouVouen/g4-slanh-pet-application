import 'package:flutter/material.dart';

import '../models/service_location.dart';
import 'service_list_tile.dart';

/// Draggable bottom sheet listing the services currently visible on the map.
class ServicesSheet extends StatelessWidget {
  const ServicesSheet({
    super.key,
    required this.scrollController,
    required this.locations,
    required this.showingClinicsOnly,
    required this.onLocationTap,
    required this.onDirections,
  });

  final ScrollController scrollController;
  final List<ServiceLocation> locations;
  final bool showingClinicsOnly;
  final ValueChanged<ServiceLocation> onLocationTap;
  final ValueChanged<ServiceLocation> onDirections;

  static const Color subtitleGray = Color(0xFF8C97A3);

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
            showingClinicsOnly
                ? '${locations.length} clinics nearby'
                : '${locations.length} services nearby',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          if (locations.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Text(
                'No matches found. Try a different search.',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: subtitleGray,
                ),
              ),
            ),
          for (final location in locations) ...[
            ServiceListTile(
              location: location,
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
