import 'package:flutter/material.dart';
import 'package:pomodoro/screens/history_screen.dart';
import 'package:pomodoro/widgets/bottomControls.dart';
import 'package:pomodoro/widgets/motivationCard.dart';
import 'package:pomodoro/widgets/notebook_background.dart';
import 'package:pomodoro/widgets/backButton.dart';
import 'package:pomodoro/widgets/tomato_timer.dart';
import 'package:pomodoro/widgets/topBar.dart';

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
                TopBar(),
                SizedBox(height: 40),
                TomatoTimer(time: "25:00"),
                const Spacer(flex: 2),
                MotivationCard(),
                const Spacer(flex: 1),
                BottomControls(),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
