import 'package:flutter/material.dart';

class BottomControls extends StatelessWidget {
  const BottomControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        BottomButton(Icons.refresh, Color(0xFFA8C5B5)),
        BottomButton(Icons.play_arrow, Color(0xFFE65A4F)),
        BottomButton(Icons.history, Color(0xFFF4B63D)),
      ],
    );
  }
}

class BottomButton extends StatelessWidget {
  final IconData icon;
  final Color color;

  const BottomButton(this.icon, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 0.02,
      child: Container(
        width: 80,
        height: 80,
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
        child: Icon(icon, size: 30, color: Colors.black),
      ),
    );
  }
}
