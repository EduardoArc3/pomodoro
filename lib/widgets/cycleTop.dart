import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CycleTop extends StatelessWidget {
  const CycleTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.01,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFF5A623), width: 4),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          "Ciclo 1 de 4",
          style: GoogleFonts.patrickHand(fontSize: 18, color: Colors.black87),
        ),
      ),
    );
  }
}
