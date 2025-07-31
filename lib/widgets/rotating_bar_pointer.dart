import 'dart:math';

import 'package:flutter/material.dart';

class RotatingBarsPainter extends CustomPainter {
  final Color color;
  final int barCount;
  final double minOpacity;
  final double maxOpacity;

  RotatingBarsPainter({
    required this.color,
    this.barCount = 8,
    this.minOpacity = 0.3,
    this.maxOpacity = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final strokeWidth = 3.0;
    final radius = size.shortestSide / 2 - strokeWidth;
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < barCount; i++) {
      final angle = i * (2 * pi / barCount);
      final alpha = i < 3
          ? maxOpacity
          : minOpacity; // You can make this dynamic if needed

      final startRadius = radius * 0.4;
      final endRadius = radius * 0.8;

      final startX = center.dx + cos(angle) * startRadius;
      final startY = center.dy + sin(angle) * startRadius;
      final endX = center.dx + cos(angle) * endRadius;
      final endY = center.dy + sin(angle) * endRadius;

      paint.color = color.withOpacity(alpha);

      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
