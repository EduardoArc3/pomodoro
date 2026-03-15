import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro/screens/settting_screen.dart';

class Initialsplash extends StatefulWidget {
  const Initialsplash({super.key});

  @override
  State<Initialsplash> createState() => _InitialsplashState();
}

class _InitialsplashState extends State<Initialsplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E4DD),
      body: Stack(
        children: [
          _buildNotebookBackground(),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  ///Tomat
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 3),
                      color: Colors.white,
                    ),
                    child: const Text("🍅", style: TextStyle(fontSize: 32)),
                  ),

                  const SizedBox(height: 25),

                  Image.asset('assets/images/Logouson.png', width: 130),

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

                  ///subtitle
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    color: Color(0xFFE65A4F),
                    child: const Text(
                      "¡Descubre la técnica pomodoro!",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),

                  const SizedBox(height: 30),

                  _featureCard(
                    icon: Icons.access_time,
                    title: "Sesiones enfocadas",
                    subtitle: "Minutos de concentración",
                    borderColor: Colors.red,
                  ),

                  const SizedBox(height: 12),

                  _featureCard(
                    icon: Icons.circle_outlined,
                    title: "Descansos productivos",
                    subtitle: "Recupera tu energía",
                    borderColor: Colors.green,
                  ),

                  const SizedBox(height: 12),

                  _featureCard(
                    icon: Icons.psychology,
                    title: "Mejora tu enfoque",
                    subtitle:
                        "Aumento de productividad comprobado científicamente",
                    borderColor: Colors.orange,
                  ),

                  const SizedBox(height: 30),

                  GestureDetector(
                    onTap: () {
                      //Navigator.pushReplacement(
                      //context,
                      //MaterialPageRoute(
                      //   builder: (context) => const TriviaScreen()),
                      // );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE65A4F),
                        border: Border.all(color: Colors.black, width: 5),
                      ),
                      child: const Center(
                        child: Text(
                          "Inicio",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blueGrey,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          "Equipo de Desarrollo",
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(height: 6),
                        Text("papu1 papu2"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor, width: 3),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Icon(icon),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(subtitle, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///Background
  Widget _buildNotebookBackground() {
    return CustomPaint(painter: _NotebookPainter(), size: Size.infinite);
  }
}

class _NotebookPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.3)
      ..strokeWidth = 1;

    const spacing = 22;

    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
