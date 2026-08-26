import 'package:flutter/material.dart';

import '../models/service_location.dart';

/// A pill-shaped marker showing a service's rating, used on the map.
class MapPin extends StatelessWidget {
  const MapPin({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset('assets/images/clinic_marker.png'),
    );
  }
}
