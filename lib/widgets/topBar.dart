import 'package:flutter/material.dart';
import 'package:pomodoro/screens/finishSesion.dart';
import 'package:pomodoro/widgets/backButton.dart';
import 'package:pomodoro/widgets/closeButton.dart';
import 'package:pomodoro/widgets/cycleTop.dart';

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
        CloseButtonn(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                opaque: false,
                barrierColor: Colors.transparent,
                pageBuilder: (_, __, ___) => const FinishSesion(),
                transitionsBuilder: (_, animation, __, child) {
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
