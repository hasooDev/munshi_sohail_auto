import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 230, 206, 206),
            Color.fromARGB(255, 127, 72, 90),
            Color.fromARGB(255, 75, 25, 25),// Bright Red // Blue
          ],
        ),
      ),
      child: child,
    );
  }
}
