import 'package:latlong2/latlong.dart';

import '../models/service_location.dart';

/// Sample pet-service locations spread across central Phnom Penh.
const List<ServiceLocation> phnomPenhServiceLocations = [
  ServiceLocation(
    name: 'PawCare Clinic BKK1',
    distanceKm: 0.8,
    rating: 4.9,
    position: LatLng(11.5480, 104.9270),
    isClinic: true,
  ),
  ServiceLocation(
    name: "Mekong Riverside Grooming",
    distanceKm: 1.2,
    rating: 4.8,
    position: LatLng(11.5694, 104.9282),
    isClinic: false,
  ),
  ServiceLocation(
    name: 'Happy Tails Vet Toul Kork',
    distanceKm: 1.6,
    rating: 4.7,
    position: LatLng(11.5730, 104.8930),
    isClinic: true,
  ),
  ServiceLocation(
    name: 'Chroy Changvar Animal Hospital',
    distanceKm: 2.1,
    rating: 4.6,
    position: LatLng(11.5850, 104.9250),
    isClinic: true,
  ),
  ServiceLocation(
    name: 'Cozy Pet Hotel Sen Sok',
    distanceKm: 2.4,
    rating: 4.5,
    position: LatLng(11.5950, 104.8850),
    isClinic: false,
  ),
  ServiceLocation(
    name: 'VetFirst Clinic Chamkarmon',
    distanceKm: 3.0,
    rating: 4.9,
    position: LatLng(11.5470, 104.9180),
    isClinic: true,
  ),
];
