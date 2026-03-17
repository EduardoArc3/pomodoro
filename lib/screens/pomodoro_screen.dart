import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/bottomControls.dart';
import 'package:pomodoro/widgets/motivationCard.dart';
import 'package:pomodoro/widgets/notebook_background.dart';
import 'package:pomodoro/widgets/tomato_timer.dart';
import 'package:pomodoro/widgets/topBar.dart';

class PomodoroScreen extends StatefulWidget {
  final int workTime;
  final int breakTime;
  final int cycles;

  const PomodoroScreen({
    super.key,
    required this.workTime,
    required this.breakTime,
    required this.cycles,
  });

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  late int remainingSeconds;
  int currentCycle = 1;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.workTime * 60;
    startTimer();
  }

  void startTimer() async {
    while (remainingSeconds > 0) {
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      setState(() {
        remainingSeconds--;
      });
    }
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;

    return "${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

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

                TopBar(currentCycle: currentCycle, totalCycles: widget.cycles),

                const SizedBox(height: 40),

                TomatoTimer(time: formatTime(remainingSeconds)),

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
