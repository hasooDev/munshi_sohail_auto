import 'dart:math';

import 'package:flutter/material.dart';

import 'rotating_bar_pointer.dart'; // Make sure this import path is correct

class CustomRotatingLoader extends StatefulWidget {
  final double size;
  final Color color;
  final Duration duration;
  final Color backgroundColor;
  final bool withCard;

  const CustomRotatingLoader({
    super.key,
    this.size = 48.0,
    this.color = const Color(0xFF5669FF),
    this.duration = const Duration(milliseconds: 1000),
    this.backgroundColor = Colors.white,
    this.withCard = true,
  });

  @override
  State<CustomRotatingLoader> createState() => _CustomRotatingLoaderState();
}

class _CustomRotatingLoaderState extends State<CustomRotatingLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loader = SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: CustomPaint(
            size: Size(widget.size, widget.size),
            painter: RotatingBarsPainter(color: widget.color),
          ),
        ),
      ),
    );

    if (!widget.withCard) return Center(child: loader);

    return Center(
      child: Card(
        elevation: 8,
        color: widget.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: loader,
        ),
      ),
    );
  }
}
