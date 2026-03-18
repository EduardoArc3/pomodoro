import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Record extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final dynamic cycles;
  final bool completed;
  final int totalTime;
  final VoidCallback onPin;
  final bool isPinned;

  const Record({
    required this.title,
    required this.description,
    required this.date,
    required this.completed,
    required this.cycles,
    required this.totalTime,
    required this.onPin,
    required this.isPinned,
    super.key,
  });

  void _showContextMenu(BuildContext context, Color themeColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8F0),
              border: Border.all(color: Colors.black, width: 5),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(5, 5),
                  blurRadius: 0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.patrickHand(fontSize: 30)),
                const Divider(color: Colors.black, thickness: 2),
                const SizedBox(height: 10),
                Text(description, style: GoogleFonts.patrickHand(fontSize: 22)),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      onPin();
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isPinned
                            ? Color(0xFFFF5C5C)
                            : const Color(0xFF00C950),
                        border: Border.all(color: Colors.black, width: 3),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(3, 3),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/tomatoes/tomate_like.png',
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isPinned ? "Desfijar" : "Fijar",
                            style: GoogleFonts.patrickHand(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color color = completed ? Color(0xFF00C950) : Color(0xFFFF5C5C);

    return Container(
      margin: const EdgeInsets.only(bottom: 5.0, top: 10.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onLongPress: () => _showContextMenu(context, color),
            child: Container(
              margin: EdgeInsets.only(bottom: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.95),
                border: Border.all(color: color, width: 5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    offset: Offset(3, 3),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        completed
                            ? Text(
                                title,
                                style: GoogleFonts.patrickHand(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFE2E2),
                                  border: Border.all(
                                    color: Color(0xFFFF5C5C),
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  "Incompleto",
                                  style: GoogleFonts.patrickHand(
                                    fontSize: 20,
                                    color: Color(0xFFFF5C5C),
                                  ),
                                ),
                              ),
                        const SizedBox(height: 10),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                color: color,
                                size: 18,
                              ),
                              VerticalDivider(
                                color: Color(0xFFD1D5DC),
                                thickness: 1,
                              ),
                              Text(
                                date,
                                style: GoogleFonts.patrickHand(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              VerticalDivider(
                                color: Color(0xFFD1D5DC),
                                thickness: 1,
                              ),
                              Text(
                                "$cycles ciclos",
                                style: GoogleFonts.patrickHand(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              VerticalDivider(
                                color: Color(0xFFD1D5DC),
                                thickness: 1,
                              ),
                              Text(
                                "$totalTime min",
                                style: GoogleFonts.patrickHand(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16),

                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: color, width: 3),
                    ),
                    child: Icon(
                      completed ? Icons.check_rounded : Icons.close_rounded,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (isPinned)
            Positioned(
              top: -15,
              left: -15,
              child: Transform.rotate(
                angle: -0.15,
                child: Image.asset(
                  'assets/images/tomatoes/tomate_like.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
