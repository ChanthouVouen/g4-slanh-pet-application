import 'package:flutter/material.dart';

import '../models/service_location.dart';

/// A pill-shaped marker showing a service's rating, used on the map.
class MapPin extends StatelessWidget {
  const MapPin({super.key, required this.location, required this.onTap});

  final ServiceLocation location;
  final VoidCallback onTap;

  static const Color orange = Color(0xFFFF663C);
  static const Color blue = Color(0xFF4C6FFF);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset('assets/images/clinic_marker.png'),
    );
  }
}
