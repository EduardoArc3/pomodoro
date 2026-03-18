import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pomodoro/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('es_MX', null);
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.patrickHandTextTheme()),
      debugShowCheckedModeBanner: false,
      home: Initialsplash(),
    );
  }
}
