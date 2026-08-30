import 'package:flutter/material.dart';

/// Circular white back button, typically placed over a header image.
class CircleBackButton extends StatelessWidget {
  const CircleBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 20,
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
        onPressed: () => Navigator.maybePop(context),
      ),
    );
  }
}
