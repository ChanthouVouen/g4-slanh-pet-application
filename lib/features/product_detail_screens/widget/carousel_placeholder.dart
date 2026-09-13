import 'package:flutter/material.dart';

/// Paw-print pattern background shown while a carousel image loads or fails.
class CarouselPlaceholder extends StatelessWidget {
  const CarouselPlaceholder({super.key, required this.colors});

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: ClipRect(
        child: Stack(
          children: [
            for (final spot in _iconSpots)
              Positioned(
                left: spot.dx,
                top: spot.dy,
                child: Transform.rotate(
                  angle: spot.dx % 2 == 0 ? -0.3 : 0.3,
                  child: Icon(
                    Icons.cookie_outlined,
                    size: 46,
                    color: Colors.white.withValues(alpha: 0.45),
                  ),
                ),
              ),
            Center(
              child: Icon(
                Icons.pets,
                size: 96,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const _iconSpots = [
    Offset(20, 30),
    Offset(280, 40),
    Offset(60, 220),
    Offset(320, 200),
    Offset(160, 20),
    Offset(10, 130),
  ];
}
