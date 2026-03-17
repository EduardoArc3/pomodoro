import 'package:flutter/material.dart';
import 'package:pomodoro/screens/history_screen.dart';
import 'package:pomodoro/widgets/notebook_background.dart';
import 'package:pomodoro/widgets/backButton.dart';
import 'package:pomodoro/widgets/tomato_timer.dart';

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E4DD),
      body: NotebookBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 10),
                SizedBox(height: 10),
                TomatoTimer(time: "25:00"),
                SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
