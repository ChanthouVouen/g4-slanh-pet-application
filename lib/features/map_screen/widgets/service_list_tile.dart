import 'package:flutter/material.dart';

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
                          color: subtitleGray,
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
                          color: subtitleGray,
                        ),
                      ),
                    ],
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
        color: location.isClinic
            ? const Color(0xFFFCE4E1)
            : const Color(0xFFFCE8D6),
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
    return Icon(
      location.isClinic
          ? Icons.medical_services_rounded
          : Icons.content_cut_rounded,
      color: const Color(0xFF49345C),
      size: 22,
    );
  }
}
