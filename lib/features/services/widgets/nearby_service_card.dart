import 'package:flutter/material.dart';

import '../models/nearby_service.dart';

class NearbyServiceCard extends StatelessWidget {
  const NearbyServiceCard({
    super.key,
    required this.service,
    required this.onTap,
  });

  final NearbyService service;
  final VoidCallback onTap;

  static const Color _subtitleGray = Color(0xFF8C97A3);
  static const Color _orange = Color(0xFFFF663C);

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
                service.tags.join(' • '),
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: _subtitleGray,
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
                    '${service.rating} (${service.reviewCount})',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.location_on_rounded,
                    size: 14,
                    color: _subtitleGray,
                  ),
                  Text(
                    ' ${service.distanceKm.toStringAsFixed(1)} km',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: _subtitleGray,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    service.priceFrom,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: _orange,
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

  final NearbyService service;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            // color: service.accentColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(service.imageUrl),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
        if (service.isOpenNow)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF34C77B),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Text(
                'Open Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
