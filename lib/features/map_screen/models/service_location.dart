import 'package:latlong2/latlong.dart';

class ServiceLocation {
  const ServiceLocation({
    required this.id,
    required this.name,
    required this.address,
    required this.position,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String address;
  final LatLng position;
  final String? imageUrl;
}
