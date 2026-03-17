import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/backButton.dart';
import 'package:pomodoro/widgets/closeButton.dart';
import 'package:pomodoro/widgets/cycleTop.dart';
import 'package:pomodoro/screens/pomodoro_screen.dart';

class TopBar extends StatelessWidget {
  final int currentCycle;
  final int totalCycles;

  const TopBar({
    super.key,
    required this.currentCycle,
    required this.totalCycles,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButtonn(
          icon: Icons.arrow_back,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        CycleTop(currentCycle: 1, totalCycles: totalCycles),
        CloseButtonn(),
      ],
    );
  }
}
