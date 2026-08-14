import 'package:latlong2/latlong.dart';

class ServiceLocation {
  const ServiceLocation({
    required this.name,
    required this.distanceKm,
    required this.rating,
    required this.position,
    required this.isClinic,
  });

  final String name;
  final double distanceKm;
  final double rating;
  final LatLng position;
  final bool isClinic;
}
