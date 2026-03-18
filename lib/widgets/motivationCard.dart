import 'package:flutter/material.dart';

class MotivationCard extends StatelessWidget {
  const MotivationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 0.06,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 25),
        decoration: BoxDecoration(
          color: const Color(0xFFF4B63D),
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: const [
            BoxShadow(color: Colors.black, offset: Offset(6, 6)),
          ],
        ),
        child: const Text(
          "¡Tú puedes!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
