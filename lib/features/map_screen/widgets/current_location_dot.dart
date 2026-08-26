import 'package:flutter/material.dart';

/// A small blue dot marking the user's current position on the map.
class CurrentLocationDot extends StatelessWidget {
  const CurrentLocationDot({super.key});

  static const Color blue = Color(0xFF4C6FFF);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      child: Image.asset('assets/images/cute_cat.png'),
    );
  }
}
