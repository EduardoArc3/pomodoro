import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:pomodoro/screens/settting_screen.dart';
import 'package:pomodoro/widgets/notebook_background.dart';

class Initialsplash extends StatefulWidget {
  const Initialsplash({super.key});

  @override
  State<Initialsplash> createState() => _InitialsplashState();
}

class _InitialsplashState extends State<Initialsplash> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: GoogleFonts.patrickHandTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF8F0),
        body: NotebookBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  ///Tomatoe
                  Transform.rotate(
                    angle: -0.15,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 3),
                        color: Color(0xFFFFF8F0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            offset: Offset(4, 4),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/tomatoes/t1.png',
                        width: 40,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Image.asset('assets/images/Logouson.png', width: 150),

                  const SizedBox(height: 20),

                  ///title
                  Text(
                    "POMODORO",
                    style: GoogleFonts.patrickHand(
                      fontSize: 55,
                      color: const Color(0xFFE65A4F),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Transform.rotate(
                    angle: 0.03,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(color: const Color(0xFFE65A4F)),
                      child: const Text(
                        "¡Confía en la técnica podomoro!",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  _featureCard(
                    icon: Icons.schedule,
                    title: "Sesiones enfocadas",
                    subtitle: "Minutos de concentración",
                    borderColor: Colors.red,
                  ),

                  const SizedBox(height: 12),

                  _featureCard(
                    icon: Icons.track_changes,
                    title: "Descansos productivos",
                    subtitle: "Recupera tu energía",
                    borderColor: Color(0xFF7DC9A8),
                  ),

                  const SizedBox(height: 12),

                  _featureCard(
                    icon: Icons.psychology,
                    title: "Mejora tu enfoque",
                    subtitle:
                        "Aumento de productividad comprobado científicamente",
                    borderColor: Color(0xFFF5A623),
                  ),

                  const SizedBox(height: 30),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE65A4F),
                        border: Border.all(color: Colors.black, width: 5),
                        boxShadow: const [
                          BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Inicio",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  DottedBorder(
                    color: Colors.blueGrey,
                    dashPattern: [6, 3],
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: const Column(
                        children: [
                          Text(
                            "Equipo de Desarrollo",
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Arce Gaxiola Angel Eduardo\n "
                            " Montaño Lares Jessica",
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _featureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color borderColor,
  }) {
    return Transform.rotate(
      angle: 0.01, // rotation
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: borderColor, width: 4),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(3, 3),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                color: borderColor,
              ),
              child: Icon(
                icon,
                size: 22,
                color: const Color.fromARGB(255, 247, 245, 245),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
