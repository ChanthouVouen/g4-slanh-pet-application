import 'package:flutter/material.dart';

import '../models/service_location.dart';

/// One row in the services bottom sheet, with a shortcut to get directions.
class ServiceListTile extends StatelessWidget {
  const ServiceListTile({
    super.key,
    required this.location,
    required this.onTap,
    required this.onDirections,
  });

  final ServiceLocation location;
  final VoidCallback onTap;
  final VoidCallback onDirections;

  static const Color subtitleGray = Color(0xFF8C97A3);
  static const Color fillGray = Color(0xFFF5F6F8);
  static const Color orange = Color(0xFFFF663C);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: fillGray,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: location.isClinic
                      ? const Color(0xFFFCE4E1)
                      : const Color(0xFFFCE8D6),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  location.isClinic
                      ? Icons.medical_services_rounded
                      : Icons.content_cut_rounded,
                  color: const Color(0xFF49345C),
                  size: 22,
                ),
              ),
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
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 14,
                          color: Color(0xFFFFB800),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          location.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${location.distanceKm.toStringAsFixed(1)} km',
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: subtitleGray,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Get directions',
                onPressed: onDirections,
                icon: const Icon(Icons.directions_rounded, color: orange),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
