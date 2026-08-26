import 'package:flutter/material.dart';

const String _defaultThumbnailUrl =
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg';

class NearbyService {
  const NearbyService({
    required this.name,
    required this.tags,
    required this.rating,
    required this.reviewCount,
    required this.distanceKm,
    required this.priceFrom,
    required this.isOpenNow,
    required this.accentColor,
    required this.icon,
    this.imageUrl = _defaultThumbnailUrl,
  });

  factory NearbyService.fromMap(Map<String, dynamic> map) {
    final name = map['name'] as String? ?? '';
    final clinic = map['clinic'] as String? ?? '';
    final picture = map['picture'] as String? ?? '';
    final price = (map['price'] as num?)?.toDouble() ?? 0;

    return NearbyService(
      name: name,
      tags: clinic.isNotEmpty ? [clinic] : const [],
      rating: 0,
      reviewCount: 0,
      distanceKm: 0,
      priceFrom: 'From \$${price.toStringAsFixed(0)}',
      isOpenNow: true,
      accentColor: const Color(0xFF3E7BFA),
      icon: Icons.medical_services_rounded,
      imageUrl: picture.isNotEmpty ? picture : _defaultThumbnailUrl,
    );
  }

  final String name;
  final List<String> tags;
  final double rating;
  final int reviewCount;
  final double distanceKm;
  final String priceFrom;
  final bool isOpenNow;
  final Color accentColor;
  final IconData icon;
  final String imageUrl;
}
