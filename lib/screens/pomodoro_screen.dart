import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:pomodoro/screens/history_screen.dart';
import 'package:pomodoro/services/timer_service.dart';
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
  final int currentCycle;

  const PomodoroScreen({
    super.key,
    required this.workTime,
    required this.breakTime,
    required this.cycles,
    required this.currentCycle,
  });

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  late int remainingSeconds;
  late int currentCycle;

  bool isRunning = false;
  bool isBreak = false;

  StreamSubscription? _updateSubscription;
  StreamSubscription? _finishSubscription;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.workTime * 60;

    currentCycle = widget.currentCycle;

    _updateSubscription = FlutterBackgroundService().on('update').listen((
      event,
    ) {
      if (mounted && event != null) {
        setState(() {
          remainingSeconds = event['seconds'];
        });
      }
    });

    _finishSubscription = FlutterBackgroundService().on('timerFinished').listen(
      (event) {
        if (mounted) {
          setState(() {
            isRunning = false;
          });

          Navigator.pushReplacement(
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
      },
    );
  }

  void startTimer() {
    TimerService().startTimer(remainingSeconds);
  }

  void resetTimer() {
    TimerService().pauseTimer();

    setState(() {
      remainingSeconds = widget.workTime * 60;
      isRunning = false;
      isBreak = false;
      currentCycle = 1;
    });
  }

  void toggleTimer() {
    if (isRunning) {
      TimerService().pauseTimer();
    } else {
      startTimer();
    }

    setState(() {
      isRunning = !isRunning;
    });
  }

  void goToHistory() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HistoryScreen()),
    );
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;

    return "${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _updateSubscription?.cancel();
    _finishSubscription?.cancel();
    TimerService().pauseTimer();
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
