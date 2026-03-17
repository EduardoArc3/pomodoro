import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TomatoTimer extends StatelessWidget {
  final String time;

  const TomatoTimer({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE65A4F), width: 17),
          ),
        ),

        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/tomatoes/t1.png", width: 110),
            const SizedBox(height: 20),
            Text(
              time,
              style: GoogleFonts.patrickHand(
                fontSize: 42,
                color: const Color(0xFFE65A4F),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
