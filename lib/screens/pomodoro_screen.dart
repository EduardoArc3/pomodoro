import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/bottomControls.dart';
import 'package:pomodoro/widgets/motivationCard.dart';
import 'package:pomodoro/widgets/notebook_background.dart';
import 'package:pomodoro/widgets/tomato_timer.dart';
import 'package:pomodoro/widgets/topBar.dart';
import 'dart:async';
import 'package:pomodoro/screens/breakScreen.dart';

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

  Timer? timer;
  bool isRunning = false;
  bool isBreak = false;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.workTime * 60;
  }

  void startTimer() {
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;

      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        t.cancel();

        setState(() {
          isRunning = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BreakScreen(
              workTime: widget.workTime,
              breakTime: widget.breakTime,
              currentCycle: currentCycle,
              totalCycles: widget.cycles,
            ),
          ),
        );
      }
    });
  }

  void resetTimer() {
    timer?.cancel();

    setState(() {
      remainingSeconds = widget.workTime * 60;
      isRunning = false;
      isBreak = false;
      currentCycle = 1;
    });
  }

  void toggleTimer() {
    if (isRunning) {
      timer?.cancel();
    } else {
      startTimer();
    }

    setState(() {
      isRunning = !isRunning;
    });
  }

  void goToHistory() {
    print("Historial");
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;

    return "${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalTime = isBreak ? widget.breakTime * 60 : widget.workTime * 60;

    return Scaffold(
      backgroundColor: const Color(0xFFE9E4DD),
      body: NotebookBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 20,
                right: 20,
                child: TopBar(
                  currentCycle: currentCycle,
                  totalCycles: widget.cycles,
                  workTimePerCycle: widget.workTime,
                  breakTimePerCycle: widget.breakTime,
                ),
              ),

              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: TomatoTimer(
                        time: formatTime(remainingSeconds),
                        progress: remainingSeconds / totalTime,
                      ),
                    ),

                    const SizedBox(height: 100),

                    MotivationCard(),
                  ],
                ),
              ),

              Positioned(
                bottom: 70,
                left: 20,
                right: 20,
                child: BottomControls(
                  onReset: resetTimer,
                  onPlayPause: toggleTimer,
                  onHistory: goToHistory,
                  isRunning: isRunning,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
