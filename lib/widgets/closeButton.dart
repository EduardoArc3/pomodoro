import 'package:flutter/material.dart';

class CloseButtonn extends StatelessWidget {
  final VoidCallback onTap;

  const CloseButtonn({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Transform.rotate(
        angle: 0.02,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFFE0E0),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.red, width: 4),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(3, 3)),
            ],
          ),
          child: const Icon(Icons.close, color: Colors.red),
        ),
      ),
    );
  }
}
