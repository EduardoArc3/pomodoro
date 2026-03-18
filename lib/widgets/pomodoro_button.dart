import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PomodoroButton extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final String text;
  final VoidCallback onTap;

  const PomodoroButton({
    super.key,
    required this.color,
    required this.backgroundColor,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: const [
            BoxShadow(color: Colors.black, offset: Offset(5, 5), blurRadius: 0),
          ],
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.patrickHand(fontSize: 24, color: color),
        ),
      ),
    );
  }
}
