import 'package:flutter/material.dart';

class CurrentLocationDot extends StatelessWidget {
  const CurrentLocationDot({super.key});

  static const Color blue = Color(0xFF4C6FFF);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Image.asset('assets/images/cute_cat.png'),
    );
  }
}
