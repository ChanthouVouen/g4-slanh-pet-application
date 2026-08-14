import 'package:flutter/material.dart';

import '../models/nearby_service.dart';

const List<NearbyService> nearbyServices = [
  NearbyService(
    name: 'PawCare Veterinary Clinic',
    tags: ['Vet', 'Grooming', 'Dental'],
    rating: 4.9,
    reviewCount: 428,
    distanceKm: 0.8,
    priceFrom: 'From RM45',
    isOpenNow: true,
    accentColor: Color(0xFF3E7BFA),
    icon: Icons.medical_services_rounded,
  ),
  NearbyService(
    name: "Luna's Grooming Studio",
    tags: ['Grooming', 'Pet Bath'],
    rating: 4.8,
    reviewCount: 312,
    distanceKm: 1.2,
    priceFrom: 'From RM30',
    isOpenNow: true,
    accentColor: Color(0xFFE0559B),
    icon: Icons.content_cut_rounded,
  ),
  NearbyService(
    name: 'Happy Tails Training Center',
    tags: ['Training', 'Daycare'],
    rating: 4.7,
    reviewCount: 156,
    distanceKm: 1.6,
    priceFrom: 'From RM60',
    isOpenNow: false,
    accentColor: Color(0xFF8A4FE0),
    icon: Icons.school_rounded,
  ),
];
