import 'dart:io';
import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/analysis_result.dart';
import 'secure_storage_service.dart';

/// Service class for handling all communication with the Gemini API
class GeminiApiService {
  final _secureStorageService = SecureStorageService();

  /// Transcribes an audio file using the Gemini API
  /// 
  /// Takes an [audioFilePath] pointing to an audio file (e.g., .m4a format)
  /// and returns the transcribed text as a String.
  /// Returns null if an error occurs during transcription or if no API key is configured.
  Future<String?> transcribeAudio(String audioFilePath) async {
    try {
      // Get API key from secure storage
      final apiKey = await _secureStorageService.getApiKey();
      if (apiKey == null || apiKey.isEmpty) {
        print('No API key configured. Please add your Gemini API key in settings.');
        return null;
      }

      // Initialize the Gemini model
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      // Read the audio file
      final audioFile = File(audioFilePath);
      final audioBytes = await audioFile.readAsBytes();

      // Create a DataPart for the audio
      final audioDataPart = DataPart('audio/mp4', audioBytes);

      // Prepare the content to send
      final content = Content.multi([
        TextPart('Transcribe this audio file.'),
        audioDataPart,
      ]);

      // Send the request to Gemini API
      final response = await model.generateContent([content]);

      // Return the transcribed text
      return response.text;
    } catch (e) {
      // Log the error and return null
      print('Error transcribing audio: $e');
      return null;
    }
  }

  Future<AnalysisResult?> analyzeText(String textToAnalyze) async {
    try {
      // Get API key from secure storage
      final apiKey = await _secureStorageService.getApiKey();
      if (apiKey == null || apiKey.isEmpty) {
        print('No API key configured. Please add your Gemini API key in settings.');
        return null;
      }

      // Initialize the Gemini model
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt = [
        Content.text(
          'Analyze the following text. Your response MUST be a single, valid JSON object with these exact keys: "summary", "sentiment", "key_phrases", "topics".\n\n'
          'Text to analyze:\n'
          '"""$textToAnalyze"""'
        )
      ];

      final response = await model.generateContent(prompt);

      if (response.text == null) {
        throw Exception('Received null response from API');
      }

      String cleanedJsonString = response.text!
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();
      
      final Map<String, dynamic> jsonData = jsonDecode(cleanedJsonString);
      return AnalysisResult.fromJson(jsonData);

    } catch (e) {
      print('Error analyzing text: $e');
      return null;
    }
  }
} 