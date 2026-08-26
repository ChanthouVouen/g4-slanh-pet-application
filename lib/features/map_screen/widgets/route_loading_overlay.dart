import 'package:flutter/material.dart';

/// Dims the map while the current location and route are being fetched.
class RouteLoadingOverlay extends StatelessWidget {
  const RouteLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ColoredBox(
        color: Colors.black.withValues(alpha: 0.15),
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}
