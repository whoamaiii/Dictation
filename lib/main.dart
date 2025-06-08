import 'package:flutter/material.dart';
import 'screens/dictation_screen.dart';

void main() {
  runApp(const TranscriptionApp());
}

class TranscriptionApp extends StatelessWidget {
  const TranscriptionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transcription App',
      theme: ThemeData.dark().copyWith(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const DictationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
} 