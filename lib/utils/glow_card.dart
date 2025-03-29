import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class NeonCard extends StatefulWidget {
  final Widget child;
  final double intensity;
  final double glowSpread;
  final List<Color> borderColors;

  const NeonCard({
    super.key,
    required this.child,
    this.intensity = 0.3,
    this.glowSpread = 4.0,
    this.borderColors = const [Colors.pink, Colors.cyan], // Default gradient
  });

  @override
  _NeonCardState createState() => _NeonCardState();
}

class _NeonCardState extends State<NeonCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: GlowRectanglePainter(
            progress: _controller.value,
            intensity: widget.intensity,
            glowSpread: widget.glowSpread,
            borderColors: widget.borderColors,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Padding to prevent clipping
            child: widget.child,
          ),
        );
      },
    );
  }
}

class GlowRectanglePainter extends CustomPainter {
  final double progress;
  final double intensity;
  final double glowSpread;
  final List<Color> borderColors;

  GlowRectanglePainter({
    required this.progress,
    this.intensity = 0.3,
    this.glowSpread = 4.0,
    required this.borderColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(12));

    // Create a gradient shader for the border
    final gradient = ui.Gradient.linear(
      rect.topLeft,
      rect.bottomRight,
      borderColors,
    );

    // Apply a glow effect around the border
    final glowPaint = Paint()
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, glowSpread)
      ..shader = gradient
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6; // Increase stroke width for a prominent glow

    canvas.drawRRect(rrect, glowPaint);

    // Draw actual gradient border
    final borderPaint = Paint()
      ..shader = gradient
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawRRect(rrect, borderPaint);
  }

  @override
  bool shouldRepaint(GlowRectanglePainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.intensity != intensity ||
      oldDelegate.glowSpread != glowSpread ||
      oldDelegate.borderColors != borderColors;
}
