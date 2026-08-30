import 'package:flutter/material.dart';

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
