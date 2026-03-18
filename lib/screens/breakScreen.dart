import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/notebook_background.dart';
import 'package:pomodoro/widgets/topBar.dart';
import 'package:pomodoro/widgets/bottomControls.dart';
import 'package:pomodoro/widgets/motivationCard.dart';

class BreakScreen extends StatelessWidget {
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
                  currentCycle: currentCycle,
                  totalCycles: totalCycles,
                  workTimePerCycle: workTime,
                  breakTimePerCycle: breakTime,
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

                    const Text(
                      "05:00",
                      style: TextStyle(fontSize: 40, color: Color(0xFF7DC9A8)),
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
                  onReset: () {},
                  onPlayPause: () {},
                  onHistory: () {},
                  isRunning: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
