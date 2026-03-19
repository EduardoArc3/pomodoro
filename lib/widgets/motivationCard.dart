import 'package:flutter/material.dart';

class MotivationCard extends StatelessWidget {
  final String text;
  final Color color;
  final double angle;

  const MotivationCard({
    super.key,
    this.text = "¡Tú puedes!",
    this.color = const Color(0xFFF4B63D),
    this.angle = 0.06,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: const [
            BoxShadow(color: Colors.black, offset: Offset(6, 6)),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 27,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
