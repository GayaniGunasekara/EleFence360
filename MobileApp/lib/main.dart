import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/events.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elephant Fence Alerts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F4F0),
        textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.black),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4E8BD4)),
      ),
      home: const EventPage(),
    );
  }
}
