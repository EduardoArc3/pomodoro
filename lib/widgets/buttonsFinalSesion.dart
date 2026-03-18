import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;
  final TextStyle? textStyle;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Transform.rotate(
        angle: 0.01,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.black, width: 5),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(5, 5)),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: textStyle ?? TextStyle(color: Colors.white, fontSize: 21),
            ),
          ),
        ),
      ),
    );
  }
}
