import 'package:flutter/material.dart';

class BackButtonn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const BackButtonn({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.02,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            border: Border.all(color: const Color(0xFF4CAF50), width: 4),

            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 155, 154, 154),
                offset: Offset(2, 2),
              ),
            ],
          ),

          child: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Color.fromARGB(255, 13, 156, 44),
          ),
        ),
      ),
    );
  }
}
