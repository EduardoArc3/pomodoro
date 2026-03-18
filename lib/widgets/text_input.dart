import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInput extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Color borderColor;
  final int maxLines;

  const TextInput({
    super.key,
    required this.hintText,
    this.controller,
    this.borderColor = Colors.black,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0, right: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            offset: Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        style: GoogleFonts.patrickHand(fontSize: 22, color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.patrickHand(
            fontSize: 22,
            color: Colors.grey.shade600,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
