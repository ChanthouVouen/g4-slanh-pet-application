import 'package:flutter/material.dart';

class CurrentLocationDot extends StatelessWidget {
  const CurrentLocationDot({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Image.asset('assets/images/cute_cat.png'),
    );
  }
}
