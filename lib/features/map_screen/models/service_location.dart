import 'package:latlong2/latlong.dart';

class ServiceLocation {
  const ServiceLocation({
    required this.id,
    required this.name,
    required this.address,
    required this.position,
    required this.isClinic,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String address;
  final LatLng position;
  final bool isClinic;
  final String? imageUrl;
}
