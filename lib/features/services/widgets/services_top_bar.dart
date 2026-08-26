import 'package:flutter/material.dart';

/// Screen title with a shortcut pill that switches to the map view.
class ServicesTopBar extends StatelessWidget {
  const ServicesTopBar({super.key, required this.onMapView});

  final VoidCallback onMapView;

  static const Color _orange = Color(0xFFFF663C);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Services',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        Material(
          color: const Color(0xFFFCE7DF),
          borderRadius: BorderRadius.circular(100),
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: onMapView,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on_rounded, size: 16, color: _orange),
                  SizedBox(width: 6),
                  Text(
                    'Map View',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _orange,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
