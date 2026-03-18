import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:pomodoro/screens/pomodoro_screen.dart';
import 'package:pomodoro/services/timer_service.dart';
import 'package:pomodoro/widgets/notebook_background.dart';
import 'package:pomodoro/widgets/topBar.dart';
import 'package:pomodoro/widgets/bottomControls.dart';
import 'package:pomodoro/widgets/motivationCard.dart';
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
  bool isRunning = false;

  StreamSubscription? _updateSubscription;
  StreamSubscription? _finishSubscription;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.breakTime * 60;

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
          _handleBreakFinished();
        }
      },
    );
  }

  void _handleBreakFinished() {
    if (widget.currentCycle < widget.totalCycles) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => PomodoroScreen(
            workTime: widget.workTime,
            breakTime: widget.breakTime,
            cycles: widget.totalCycles,
            currentCycle: widget.currentCycle + 1,
          ),
        ),
      );
    } else {
      TimerService().killService();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => FinishScreen(
            completedCycles: widget.totalCycles,
            totalCycles: widget.totalCycles,
            workTimePerCycle: widget.workTime,
            breakTimePerCycle: widget.breakTime,
          ),
        ),
      );
    }
  }

  void startTimer() {
    TimerService().startTimer(remainingSeconds);
  }

  void resetTimer() {
    TimerService().pauseTimer();

    setState(() {
      remainingSeconds = widget.breakTime * 60;
      isRunning = false;
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
                  workTimePerCycle: widget.workTime,
                  breakTimePerCycle: widget.breakTime,
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
