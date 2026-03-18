import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/notebook_background.dart';
import 'package:pomodoro/widgets/topBar.dart';
import 'package:pomodoro/widgets/bottomControls.dart';
import 'package:pomodoro/widgets/motivationCard.dart';
import 'package:pomodoro/screens/finishSesion.dart';
import 'package:pomodoro/screens/finish_screen.dart';

class BreakScreen extends StatefulWidget {
  final int breakTime;
  final int workTime;
  final int currentCycle;
  final int totalCycles;

  const BreakScreen({
    super.key,
    required this.workTime,
    required this.breakTime,
    required this.currentCycle,
    required this.totalCycles,
  });

  @override
  State<BreakScreen> createState() => _BreakScreenState();
}

class _BreakScreenState extends State<BreakScreen> {
  late int remainingSeconds;
  Timer? timer;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.breakTime * 60;
  }

  void startTimer() {
    timer?.cancel();

    if (remainingSeconds > 0) {
      setState(() {
        remainingSeconds--;
      });
    }

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

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => FinishScreen(
              completedCycles: widget.currentCycle,
              totalCycles: widget.totalCycles,
              workTimePerCycle: 25,
              breakTimePerCycle: widget.breakTime,
            ),
          ),
        );
      }
    });
  }

  void resetTimer() {
    timer?.cancel();

    setState(() {
      remainingSeconds = widget.breakTime * 60;
      isRunning = false;
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
    return Scaffold(
      body: NotebookBackground(
        overlayColor: const Color(0xFFF0FFF8),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 60,
                left: 10,
                child: Image.asset(
                  "assets/images/tomatoes/hojota.png",
                  width: 100,
                ),
              ),

              Positioned(
                top: 180,
                right: 40,
                child: Image.asset(
                  "assets/images/tomatoes/hojita.png",
                  width: 40,
                ),
              ),

              Positioned(
                top: 10,
                left: 20,
                right: 20,
                child: TopBar(
                  currentCycle: widget.currentCycle,
                  totalCycles: widget.totalCycles,
                ),
              ),

              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/tomatoes/Tómate bebé.png",
                      width: 120,
                    ),

                    const SizedBox(height: 20),

                    Text(
                      formatTime(remainingSeconds),
                      style: const TextStyle(
                        fontSize: 40,
                        color: Color(0xFF7DC9A8),
                      ),
                    ),

                    const SizedBox(height: 80),

                    const MotivationCard(),
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
                  onHistory: () {},
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
