import 'package:flutter/material.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis'),
      ),
      body: const Center(
        child: Text(
          'Analysis Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
} 