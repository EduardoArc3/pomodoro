import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/circleAction.dart';

class TimeSection extends StatelessWidget {
  final String title;
  final int value;
  final Color color;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const TimeSection({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.onMinus,
    required this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAction(text: "-", color: color, onTap: onMinus),
            Container(
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: color, width: 4),
              ),
              child: Text(
                "$value",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            CircleAction(text: "+", color: color, onTap: onPlus),
          ],
        ),
      ],
    );
  }
}
