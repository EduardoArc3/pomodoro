import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CycleTop extends StatelessWidget {
  final int currentCycle;
  final int totalCycles;

  const CycleTop({
    super.key,
    required this.currentCycle,
    required this.totalCycles,
  });

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
          boxShadow: const [
            BoxShadow(color: Colors.black, offset: Offset(3, 3), blurRadius: 0),
          ],
        ),
        child: Text(
          "Ciclo $currentCycle de $totalCycles",
          style: GoogleFonts.patrickHand(fontSize: 18, color: Colors.black87),
        ),
      ),
    );
  }
}
