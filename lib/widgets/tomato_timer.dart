import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TomatoTimer extends StatelessWidget {
  final String time;
  final double progress;
  final Color color;
  final Color emptyColor;
  final List<String> imageStages;

  const TomatoTimer({
    super.key,
    required this.time,
    required this.progress,
    required this.color,
    required this.emptyColor,
    required this.imageStages,
  });

  String getTomatoImage(double progress) {
    if (progress > 0.75) {
      return imageStages[0];
    } else if (progress > 0.5) {
      return imageStages[1];
    } else if (progress > 0.25) {
      return imageStages[2];
    } else {
      return imageStages[3];
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
            SizedBox(
              width: size,
              height: size,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(end: progress),
                duration: const Duration(seconds: 1),
                curve: Curves.linear,
                builder: (context, value, _) {
                  return CircularProgressIndicator(
                    value: value,
                    strokeWidth: size * 0.07,
                    backgroundColor: emptyColor,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    strokeCap: StrokeCap.round,
                  );
                },
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
                    color: color,
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
