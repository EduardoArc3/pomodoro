import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro/widgets/notebook_background.dart';
import 'package:pomodoro/widgets/buttonsFinalSesion.dart';

class FinishSesion extends StatelessWidget {
  const FinishSesion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E4DD),
      body: NotebookBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE65A4F),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 6),
                        boxShadow: const [
                          BoxShadow(color: Colors.black, offset: Offset(6, 6)),
                        ],
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Transform.rotate(
                      angle: -0.02,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFFE65A4F),
                            width: 4,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(6, 6),
                            ),
                          ],
                        ),
                        child: Text(
                          "¿Terminar sesión?",
                          style: GoogleFonts.patrickHand(
                            fontSize: 28,
                            color: const Color(0xFFE65A4F),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Transform.rotate(
                      angle: 0.02,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4E1B6),
                          border: Border.all(
                            color: const Color.fromARGB(255, 244, 196, 124),
                            width: 3,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(3, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          "Si sales ahora, perderás el \n progreso de este ciclo",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.patrickHand(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 25,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFF7DC9A8),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Ciclos completados:",
                            style: GoogleFonts.patrickHand(fontSize: 20),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "0 de 8",
                            style: GoogleFonts.patrickHand(
                              fontSize: 25,
                              color: Color(0xFF7DC9A8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.red, width: 3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Tiempo trabajado",
                            style: GoogleFonts.patrickHand(fontSize: 20),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "0 min",
                            style: GoogleFonts.patrickHand(
                              fontSize: 25,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    PrimaryButton(
                      text: "¡Seguir trabajando!",
                      color: const Color(0xFFA8C5B5),
                      textStyle: GoogleFonts.patrickHand(
                        fontSize: 24,
                        color: Colors.white,
                      ),

                      onTap: () => Navigator.pop(context),
                    ),
                    const SizedBox(height: 15),
                    PrimaryButton(
                      text: "Terminar sesión",
                      color: const Color(0xFFE65A4F),
                      textStyle: GoogleFonts.patrickHand(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Positioned(
                left: 10,
                top: 70,

                child: Image.asset(
                  "assets/images/tomatoes/Group 78.png",
                  width: 70,
                  height: 70,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                right: 10,
                top: 350,
                child: Image.asset(
                  "assets/images/tomatoes/ña.png",
                  width: 70,
                  height: 70,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                left: 30,
                bottom: 320,
                child: Image.asset(
                  "assets/images/tomatoes/baby.png",
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                right: 20,
                bottom: 10,
                child: Image.asset(
                  "assets/images/tomatoes/ña2.png",
                  width: 70,
                  height: 70,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
