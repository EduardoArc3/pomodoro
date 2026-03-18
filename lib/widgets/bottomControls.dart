import 'package:flutter/material.dart';

class BottomControls extends StatelessWidget {
  final VoidCallback onReset;
  final VoidCallback onPlayPause;
  final VoidCallback onHistory;
  final bool isRunning;

  const BottomControls({
    super.key,
    required this.onReset,
    required this.onPlayPause,
    required this.onHistory,
    required this.isRunning,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BottomButton(Icons.refresh, const Color(0xFF7DC9A8), onReset),
        BottomButton(
          isRunning ? Icons.pause : Icons.play_arrow,
          const Color(0xFFE65A4F),
          onPlayPause,
        ),
        BottomButton(Icons.history, const Color(0xFFF5A623), onHistory),
      ],
    );
  }
}

class BottomButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const BottomButton(this.icon, this.color, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 0.02,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.black, width: 5),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(5, 5)),
            ],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: Icon(
            icon,
            size: 45,
            color: const Color.fromARGB(255, 239, 237, 237),
          ),
        ),
      ),
    );
  }
}
