import 'package:flutter/material.dart';
import '../services/gemini_api_service.dart';
import '../models/analysis_result.dart';
import 'dart:convert'; // Already in gemini_api_service, but good for explicitness if ever needed directly here

class AnalysisScreen extends StatefulWidget {
  final String transcribedText;
  const AnalysisScreen({super.key, required this.transcribedText});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  final GeminiApiService _geminiApiService = GeminiApiService();
  AnalysisResult? _analysisResult;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAnalysis();
  }

  Future<void> _fetchAnalysis() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      final result = await _geminiApiService.analyzeText(widget.transcribedText);
      if (mounted) {
        setState(() {
          _analysisResult = result;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          // Optionally, set an error message to display
        });
      }
      print('Error fetching analysis in UI: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transcription Analysis'), // Changed title slightly for clarity
          bottom: const TabBar(
            isScrollable: true, // Makes tabs scrollable if they don't fit
            tabs: [
              Tab(text: 'Summary'),
              Tab(text: 'Sentiment'),
              Tab(text: 'Key Phrases'),
              Tab(text: 'Topics'),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Original Transcription:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                    constraints: const BoxConstraints(maxHeight: 150), // Max height for scrollable text
                    child: SingleChildScrollView(
                      child: Text(widget.transcribedText),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _analysisResult == null
                      ? Center(
                          child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Could not load analysis. Please try again later.',
                            style: TextStyle(color: Theme.of(context).colorScheme.error),
                            textAlign: TextAlign.center,
                          ),
                        ))
                      : TabBarView(
                          children: [
                            _buildTabContent(_analysisResult!.summary),
                            _buildTabContent(_analysisResult!.sentiment),
                            _buildTabContent(_analysisResult!.keyPhrases),
                            _buildTabContent(_analysisResult!.topics),
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(String text) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Text(text),
    );
  }
} 