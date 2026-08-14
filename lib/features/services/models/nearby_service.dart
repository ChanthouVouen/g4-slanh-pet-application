import 'package:flutter/material.dart';

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
  });

  final String name;
  final List<String> tags;
  final double rating;
  final int reviewCount;
  final double distanceKm;
  final String priceFrom;
  final bool isOpenNow;
  final Color accentColor;
  final IconData icon;
}
