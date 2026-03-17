import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/backButton.dart';
import 'package:pomodoro/widgets/closeButton.dart';
import 'package:pomodoro/widgets/cycleTop.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

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
        CycleTop(),
        CloseButtonn(),
      ],
    );
  }
}
