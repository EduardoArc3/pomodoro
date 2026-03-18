import 'package:flutter/material.dart';
import 'package:pomodoro/screens/finishSesion.dart';
import 'package:pomodoro/widgets/backButton.dart';
import 'package:pomodoro/widgets/closeButton.dart';
import 'package:pomodoro/widgets/cycleTop.dart';

class TopBar extends StatelessWidget {
  final int currentCycle;
  final int totalCycles;
  final int workTimePerCycle;
  final int breakTimePerCycle;

  const TopBar({
    super.key,
    required this.currentCycle,
    required this.totalCycles,
    required this.workTimePerCycle,
    required this.breakTimePerCycle,
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
        CloseButtonn(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                opaque: false,
                barrierColor: Colors.transparent,
                pageBuilder: (_, _, _) => FinishSesion(
                  currentCycle: currentCycle,
                  totalCycles: totalCycles,
                  workTimePerCycle: workTimePerCycle,
                  breakTimePerCycle: breakTimePerCycle,
                ),
                transitionsBuilder: (_, animation, _, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
