import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro/screens/history_screen.dart';
import 'package:pomodoro/widgets/notebook_background.dart';
import 'package:pomodoro/widgets/timeSection.dart';
import 'package:pomodoro/widgets/backButton.dart';
import 'package:pomodoro/widgets/iconClock.dart';
import 'package:pomodoro/screens/home_screen.dart';
import 'package:pomodoro/screens/pomodoro_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreen();
}

class _SettingScreen extends State<SettingScreen> {
  int workTime = 25;
  int breakTime = 5;
  int cycles = 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: NotebookBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButtonn(
                      icon: Icons.arrow_back,
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Initialsplash(),
                          ),
                        );
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            offset: Offset(3, 3),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: iconClock(
                        icon: Icons.history,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HistoryScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

                Image.asset('assets/images/Logouson.png', width: 150),
                const SizedBox(height: 10),

                Text(
                  "POMODORO",
                  style: GoogleFonts.patrickHand(
                    fontSize: 40,
                    color: const Color(0xFFE65A4F),
                  ),
                ),
                const SizedBox(height: 5),

                const Text(
                  "¡Trabaja con enfoque y descansa con \n propósito!",
                  textAlign: TextAlign.center,

                  style: TextStyle(fontSize: 17, color: Colors.blue),
                ),
                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    border: Border.all(
                      color: const Color(0xFFFF5C5C),
                      width: 5,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(6, 6),
                        blurRadius: 0,
                      ),
                    ],
                  ),

                  child: Column(
                    children: [
                      Text(
                        "Configura tu sesión",
                        style: GoogleFonts.patrickHand(
                          fontSize: 23,
                          color: const Color(0xFFFF5C5C),
                        ),
                      ),

                      const SizedBox(height: 20),

                      TimeSection(
                        title: "Tiempo de trabajo (min)",
                        value: workTime,
                        color: Color(0xFFFF5C5C),
                        onMinus: () {
                          setState(() {
                            if (workTime > 1) workTime--;
                          });
                        },
                        onPlus: () {
                          setState(() {
                            if (workTime < 60) workTime++;
                          });
                        },
                      ),

                      const SizedBox(height: 20),

                      TimeSection(
                        title: "Tiempo de descanso (min)",
                        value: breakTime,
                        color: Color(0xFF5DADE2),
                        onMinus: () {
                          setState(() {
                            if (breakTime > 1) breakTime--;
                          });
                        },
                        onPlus: () {
                          setState(() {
                            if (breakTime < 30) breakTime++;
                          });
                        },
                      ),

                      const SizedBox(height: 20),

                      TimeSection(
                        title: "Número de ciclos",
                        value: cycles,
                        color: Color(0xFFF4D03F),
                        onMinus: () {
                          setState(() {
                            if (cycles > 1) cycles--;
                          });
                        },
                        onPlus: () {
                          setState(() {
                            if (cycles < 8) cycles++;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PomodoroScreen(
                          workTime: workTime,
                          breakTime: breakTime,
                          cycles: cycles,
                          currentCycle: 1,
                        ),
                      ),
                    );
                  },

                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 22),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE65A4F),
                      border: Border.all(color: Colors.black, width: 5),
                      boxShadow: const [
                        BoxShadow(color: Colors.black, offset: Offset(6, 6)),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "¡Comenzar! 🍅",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
