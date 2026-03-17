import 'package:flutter/material.dart';

class iconClock extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const iconClock({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.02,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.shade200,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.orange, width: 4),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 155, 154, 154),
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Icon(icon, size: 20, color: Colors.orange.shade800),
        ),
      ),
    );
  }
}
