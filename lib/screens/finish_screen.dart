import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro/models/history_record.dart';
import 'package:pomodoro/screens/home_screen.dart';
import 'package:pomodoro/screens/pomodoro_screen.dart';
import 'package:pomodoro/services/database_service.dart';
import 'package:pomodoro/widgets/notebook_background.dart';
import 'package:pomodoro/widgets/pomodoro_button.dart';
import 'package:pomodoro/widgets/text_input.dart';

class FinishScreen extends StatefulWidget {
  final int completedCycles;
  final int totalCycles;
  final int workTimePerCycle;
  final int breakTimePerCycle;

  const FinishScreen({
    super.key,
    required this.completedCycles,
    required this.totalCycles,
    required this.workTimePerCycle,
    required this.breakTimePerCycle,
  });

  @override
  State<StatefulWidget> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  Future<void> _saveAndExit() async {
    String title = _titleController.text.trim();
    if (title.isEmpty) title = "Sesión sin título";

    String desc = _descController.text.trim();
    int totalTime = widget.workTimePerCycle * widget.completedCycles;

    final newRecord = HistoryRecord(
      title: title,
      description: desc,
      date: DateTime.now(),
      isCompleted: widget.completedCycles == widget.totalCycles,
      cycles: "${widget.completedCycles}/${widget.totalCycles}",
      totalTime: totalTime,
      isPinned: false,
    );

    await DatabaseService.instance.insertRecord(newRecord);

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Initialsplash()),
      );
    }
  }

  Future<void> _saveAndRepeat() async {
    String title = _titleController.text.trim();
    if (title.isEmpty) title = "Sesión sin título";

    String desc = _descController.text.trim();
    int totalTime = widget.workTimePerCycle * widget.completedCycles;

    final newRecord = HistoryRecord(
      title: title,
      description: desc,
      date: DateTime.now(),
      isCompleted: widget.completedCycles == widget.totalCycles,
      cycles: "${widget.completedCycles}/${widget.totalCycles}",
      totalTime: totalTime,
      isPinned: false,
    );

    await DatabaseService.instance.insertRecord(newRecord);

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PomodoroScreen(
            workTime: widget.workTimePerCycle,
            breakTime: widget.breakTimePerCycle,
            cycles: widget.totalCycles,
            currentCycle: 1,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isFullyCompleted = widget.completedCycles == widget.totalCycles;

    Color themeColor = isFullyCompleted
        ? const Color(0xFFA7D7C5)
        : const Color(0xFFFF5C5C);
    Color bgColor = isFullyCompleted
        ? Color(0xFFE8F5E9)
        : const Color(0xFFFFE2E2);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: NotebookBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: themeColor,
                      border: Border.all(color: Colors.black, width: 5),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(5, 5),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: Icon(
                      isFullyCompleted
                          ? Icons.check_circle_outline_rounded
                          : Icons.close_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Transform.rotate(
                  angle: -0.05,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: themeColor, width: 5),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(4, 4),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: Text(
                          isFullyCompleted
                              ? "¡Sesión completada!"
                              : "Sesión incompleta",
                          style: GoogleFonts.patrickHand(
                            fontSize: 30,
                            color: themeColor,
                          ),
                        ),
                      ),
                      Positioned(
                        top: -20,
                        left: -20,
                        child: Image.asset(
                          'assets/images/tomatoes/tomate_bebe_like.png',
                          height: 50,
                          width: 50,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        bottom: -15,
                        right: -15,
                        child: Image.asset(
                          'assets/images/tomatoes/tomate_felis.png',
                          height: 50,
                          width: 50,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          color: bgColor,
                          border: Border.all(color: themeColor, width: 5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              offset: Offset(4, 4),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: Text(
                          isFullyCompleted
                              ? "¡Excelente trabajo! Completaste todos tus ciclos"
                              : "Sesión detenida. ¡Sigue intentándolo!",
                          style: GoogleFonts.patrickHand(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // ciclos
                          _buildInfoCard(
                            "Ciclos",
                            "${widget.completedCycles}/${widget.totalCycles}",
                            Color(0xFFA7D7C5),
                          ),

                          // trabajo
                          _buildInfoCard(
                            "Trabajo",
                            "${widget.workTimePerCycle * widget.completedCycles}",
                            Color(0xFFFF5C5C),
                          ),

                          // descanso
                          _buildInfoCard(
                            "Descanso",
                            "${widget.breakTimePerCycle * widget.completedCycles}",
                            Color(0xFFFFB84D),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Nombre de la sesión:",
                          style: GoogleFonts.patrickHand(
                            fontSize: 22,
                            color: Color(0xFF364153),
                          ),
                        ),
                      ),

                      TextInput(
                        controller: _titleController,
                        hintText: "Ej. Estudiar para examen",
                        borderColor: Color(0xFFA7D7C5),
                      ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "¿Qué hiciste?",
                          style: GoogleFonts.patrickHand(
                            fontSize: 22,
                            color: Color(0xFF364153),
                          ),
                        ),
                      ),

                      TextInput(
                        controller: _descController,
                        hintText: "Describe tu sesión...",
                        borderColor: Color(0xFFA7D7C5),
                        maxLines: 4,
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 16.0,
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: PomodoroButton(
                              color: Colors.white,
                              backgroundColor: Color(0xFFA7D7C5),
                              text: "Repetir sesión",
                              onTap: _saveAndRepeat,
                            ),
                          ),

                          const SizedBox(height: 10),

                          SizedBox(
                            width: double.infinity,
                            child: PomodoroButton(
                              color: Colors.white,
                              backgroundColor: Color(0xFFFF5C5C),
                              text: "Guardar y salir",
                              onTap: _saveAndExit,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: -15,
                        left: -10,
                        child: Image.asset(
                          'assets/images/tomatoes/tomate_like.png',
                          height: 50,
                          width: 50,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        bottom: -15,
                        right: -10,
                        child: Image.asset(
                          'assets/images/tomatoes/tomate_musical.png',
                          height: 50,
                          width: 50,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: color, width: 3),
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            offset: Offset(3, 3),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.patrickHand(fontSize: 20, color: Colors.black),
          ),
          Text(
            value,
            style: GoogleFonts.patrickHand(fontSize: 20, color: color),
          ),
        ],
      ),
    );
  }
}
