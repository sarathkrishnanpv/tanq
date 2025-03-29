// import 'package:flutter/material.dart';

// class AnimatedDottedLine extends StatefulWidget {
//   final Color color;
//   final double strokeWidth;
//   final bool isVertical;

//   const AnimatedDottedLine({
//     Key? key,
//     this.color = Colors.grey,
//     this.strokeWidth = 1.0,
//     this.isVertical = true,
//   }) : super(key: key);

//   @override
//   State<AnimatedDottedLine> createState() => _AnimatedDottedLineState();
// }

// class _AnimatedDottedLineState extends State<AnimatedDottedLine>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     )..repeat();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.isVertical ? 20 : double.infinity,
//       height: widget.isVertical ? double.infinity : 20,
//       child: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           return CustomPaint(
//             painter: _DottedLinePainter(
//               color: widget.color,
//               strokeWidth: 3.0, // Fixed stroke width for better visibility
//               progress: _controller.value,
//               isVertical: widget.isVertical,
//             ),
//             size: Size.infinite,
//           );
//         },
//       ),
//     );
//   }
// }

// class _DottedLinePainter extends CustomPainter {
//   final Color color;
//   final double strokeWidth;
//   final double progress;
//   final bool isVertical;

//   _DottedLinePainter({
//     required this.color,
//     required this.strokeWidth,
//     required this.progress,
//     required this.isVertical,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..strokeWidth = strokeWidth
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.fill;

//     final dotRadius = 3.0;
//     final spacing = 15.0;
//     final totalSpacing = dotRadius * 2 + spacing;
    
//     if (isVertical) {
//       final startY = -totalSpacing + (progress * totalSpacing * 2);
//       final centerX = size.width / 2;
      
//       for (var y = startY; y < size.height + totalSpacing; y += totalSpacing) {
//         if (y >= -dotRadius && y <= size.height + dotRadius) {
//           canvas.drawCircle(
//             Offset(centerX, y),
//             dotRadius,
//             paint,
//           );
//         }
//       }
//     } else {
//       final startX = -totalSpacing + (progress * totalSpacing * 2);
//       final centerY = size.height / 2;
      
//       for (var x = startX; x < size.width + totalSpacing; x += totalSpacing) {
//         if (x >= -dotRadius && x <= size.width + dotRadius) {
//           canvas.drawCircle(
//             Offset(x, centerY),
//             dotRadius,
//             paint,
//           );
//         }
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant _DottedLinePainter oldDelegate) {
//     return oldDelegate.progress != progress;
//   }
// } 