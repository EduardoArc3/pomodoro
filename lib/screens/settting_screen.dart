import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: const Color(0xFFE9E4DD),
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
                    iconClock(icon: Icons.history, onTap: () {}),
                  ],
                ),

                const SizedBox(height: 10),
                Image.asset('assets/images/Logouson.png', width: 130),
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
                    color: Colors.grey.shade200,
                    border: Border.all(
                      color: const Color(0xFFE65A4F),
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
                          color: const Color(0xFFE65A4F),
                        ),
                      ),

                      const SizedBox(height: 20),

                      TimeSection(
                        title: "Tiempo de trabajo (min)",
                        value: workTime,
                        color: Colors.red,
                        onMinus: () {
                          setState(() {
                            if (workTime > 1) workTime--;
                          });
                        },
                        onPlus: () {
                          setState(() {
                            workTime++;
                          });
                        },
                      ),

                      const SizedBox(height: 20),

                      TimeSection(
                        title: "Tiempo de descanso (min)",
                        value: breakTime,
                        color: Colors.blue,
                        onMinus: () {
                          setState(() {
                            if (breakTime > 1) breakTime--;
                          });
                        },
                        onPlus: () {
                          setState(() {
                            breakTime++;
                          });
                        },
                      ),

                      const SizedBox(height: 20),

                      TimeSection(
                        title: "Número de ciclos",
                        value: cycles,
                        color: Colors.yellow.shade700,
                        onMinus: () {
                          setState(() {
                            if (cycles > 1) cycles--;
                          });
                        },
                        onPlus: () {
                          setState(() {
                            cycles++;
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
