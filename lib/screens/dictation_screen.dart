// IMPORTANT FOR IOS:
// You must add the following key to your ios/Runner/Info.plist file
// to request microphone permissions:
// <key>NSMicrophoneUsageDescription</key>
// <string>This app requires microphone access to record audio for transcription.</string>
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:record/record.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io'; // Required for Directory
import '../services/gemini_api_service.dart'; // Added import

class DictationScreen extends StatefulWidget {
  const DictationScreen({super.key});

  @override
  State<DictationScreen> createState() => _DictationScreenState();
}

class _DictationScreenState extends State<DictationScreen> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  final GeminiApiService _geminiApiService = GeminiApiService(); // Added service instance
  bool _isRecording = false;
  String? _audioPath;
  String _transcription = 'Transcription will appear here'; // Added state variable
  bool _isTranscribing = false; // Added state variable

  Future<void> _toggleRecording() async {
    // Check for microphone permission first
    if (!await _audioRecorder.hasPermission()) {
      // Request permission if not granted
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        // Optionally, show a dialog or snackbar to the user
        // For example, using ScaffoldMessenger:
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Microphone permission is required to record audio.')),
          );
        }
        return;
      }
    }

    if (_isRecording) {
      // Stop recording
      final String? path = await _audioRecorder.stop();

      if (path != null) {
        // If recording was successful and we have a path
        setState(() {
          _isRecording = false;
          _audioPath = path;
          _isTranscribing = true; // Start loading indicator
          _transcription = 'Transcribing...'; // Update text
        });

        // Call the API service
        final String? result = await _geminiApiService.transcribeAudio(_audioPath!);
        
        // Update the UI with the result
        setState(() {
          _transcription = result ?? 'Error: Could not transcribe audio.';
          _isTranscribing = false; // Stop loading indicator
        });
      } else {
        // Handle case where recording failed to produce a path
        setState(() {
          _isRecording = false;
        });
      }
    } else {
      // Start recording
      // Get a temporary directory to save the recording
      final Directory tempDir = await getTemporaryDirectory();
      final String filePath = '${tempDir.path}/dictation.m4a';

      // Define the recording configuration
      const RecordConfig config = RecordConfig(encoder: AudioEncoder.aacLc);

      // Start the recording
      await _audioRecorder.start(config, path: filePath);
      setState(() {
        _isRecording = true;
        _audioPath = null;
      });
    }
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background, // Default dark theme background
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // TODO: Implement navigation back
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text('Dictation'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleRecording, // No action for now
        backgroundColor: _isRecording ? Colors.redAccent : Theme.of(context).colorScheme.secondary,
        child: Icon(_isRecording ? Icons.stop : Iconsax.microphone_2),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Stack(
        children: [
          // Layer 1 - Main Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tap the microphone to start recording. Your transcription will appear here.',
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade700),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey.shade800.withOpacity(0.5),
                    ),
                    child: _isTranscribing
                        ? const Center(child: CircularProgressIndicator())
                        : SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _transcription,
                                style: TextStyle(color: _transcription.startsWith('Error:') ? Colors.redAccent : Colors.white),
                              ),
                            ),
                          ), // Updated UI for transcription display
                  ),
                ),
              ],
            ),
          ),
          // Layer 2 - Action Buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Important to keep column from expanding full height
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildActionButton(Iconsax.share, 'Share', () {
                        // TODO: Implement Share
                      }),
                      const SizedBox(width: 40), // Spacing between Share and New
                      _buildActionButton(Iconsax.add_circle, 'New', () {
                        // TODO: Implement New
                      }),
                    ],
                  ),
                  const SizedBox(height: 24), // Spacing between top row and bottom row of buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Iconsax.document_text_1), // Changed for better context
                            label: const Text('Analyze'),
                            onPressed: null, // No action for now
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              foregroundColor: Theme.of(context).colorScheme.onBackground,
                              side: BorderSide(color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Iconsax.save_2),
                            label: const Text('Save'),
                            onPressed: null, // No action for now
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28),
          const SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }
} 