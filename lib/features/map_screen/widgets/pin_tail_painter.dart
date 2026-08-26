import 'package:flutter/material.dart';

class PinTailPainter extends CustomPainter {
  const PinTailPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant PinTailPainter oldDelegate) =>
      oldDelegate.color != color;
}
