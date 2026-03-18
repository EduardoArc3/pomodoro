import 'package:flutter/material.dart';

class NotebookBackground extends StatelessWidget {
  final Widget child;
  final Color? overlayColor;

  const NotebookBackground({super.key, required this.child, this.overlayColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(painter: _NotebookPainter(), size: Size.infinite),

        if (overlayColor != null)
          Container(color: overlayColor!.withValues(alpha: 0.4)),

        child,
      ],
    );
  }
}

class _NotebookPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.3)
      ..strokeWidth = 1;

    const spacing = 22;

    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
