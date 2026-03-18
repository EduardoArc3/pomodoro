import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TomatoTimer extends StatelessWidget {
  final String time;
  final double progress;

  const TomatoTimer({super.key, required this.time, required this.progress});

  String getTomatoImage(double progress) {
    if (progress > 0.75) {
      return "assets/images/tomatoes/t1.png";
    } else if (progress > 0.5) {
      return "assets/images/tomatoes/tómate 2.png";
    } else if (progress > 0.25) {
      return "assets/images/tomatoes/tómate 3.png";
    } else {
      return "assets/images/tomatoes/tómate 4.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth;

        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFE65A4F),
                  width: size * 0.07,
                ),
              ),
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Image.asset(
                    getTomatoImage(progress),
                    key: ValueKey(getTomatoImage(progress)),
                    width: size * 0.35,
                  ),
                ),

                SizedBox(height: size * 0.08),

                Text(
                  time,
                  style: GoogleFonts.patrickHand(
                    fontSize: size * 0.17,
                    color: const Color(0xFFE65A4F),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
