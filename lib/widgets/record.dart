import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Record extends StatelessWidget {
  final String title;
  final String date;
  final dynamic cycles;
  final bool completed;
  final int totalTime;

  const Record({
    required this.title,
    required this.date,
    required this.completed,
    required this.cycles,
    required this.totalTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color color = completed ? Color(0xFF00C950) : Color(0xFFFF5C5C);

    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200.withValues(alpha: 0.9),
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
                      VerticalDivider(color: Color(0xFFD1D5DC), thickness: 1),
                      Text(
                        date,
                        style: GoogleFonts.patrickHand(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      VerticalDivider(color: Color(0xFFD1D5DC), thickness: 1),
                      Text(
                        "$cycles ciclos",
                        style: GoogleFonts.patrickHand(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      VerticalDivider(color: Color(0xFFD1D5DC), thickness: 1),
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
    );
  }
}
