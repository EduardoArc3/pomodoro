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
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.orange, width: 4),
            boxShadow: const [],
          ),
          child: Icon(icon, size: 20, color: Colors.orange.shade800),
        ),
      ),
    );
  }
}
