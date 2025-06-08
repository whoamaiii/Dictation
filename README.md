# Transcription App

A Flutter application for audio transcription using the Gemini AI API.

## Project Structure

This Flutter project has been organized with a clean architecture:

```
transcription_app/
├── lib/
│   ├── screens/          # Main UI widgets for each screen
│   │   ├── dictation_screen.dart
│   │   ├── analysis_screen.dart
│   │   └── settings_screen.dart
│   ├── services/         # Business logic (API services)
│   ├── models/           # Data models (Transcription, AnalysisResult)
│   ├── widgets/          # Reusable UI components
│   ├── providers/        # State management provider classes
│   └── main.dart         # App entry point
├── pubspec.yaml          # Dependencies and project configuration
└── analysis_options.yaml # Dart/Flutter linting rules
```

## Dependencies

The following dependencies have been added to `pubspec.yaml`:

- **`google_generative_ai`**: For interacting with the Gemini API to perform transcription and analysis
- **`record`**: For recording audio from the device microphone
- **`path_provider`**: To find the correct local paths for saving audio recordings on different platforms
- **`permission_handler`**: To request and manage microphone and storage permissions from users
- **`provider`**: For simple and efficient state management across the app
- **`iconsax`**: For modern, consistent icons in the user interface

## Getting Started

1. **Install Flutter**: Make sure you have Flutter installed on your system. Visit [Flutter.dev](https://flutter.dev) for installation instructions.

2. **Install Dependencies**: Run the following command in the project directory:
   ```bash
   flutter pub get
   ```

3. **Configure Gemini API**: You'll need to add your Gemini API key to the app configuration.

4. **Run the App**: Use the following command to run the app:
   ```bash
   flutter run
   ```

## Features to Implement

The project structure is ready for implementing:

- Audio recording functionality
- Gemini API integration for transcription
- Real-time transcription display
- Audio analysis and insights
- Settings management
- File management for recordings

## Theme

The app uses a dark theme with:
- Black background
- Dark app bars
- Blue accent colors
- White text for good contrast

## Next Steps

1. Run `flutter pub get` to install all dependencies
2. Implement the audio recording service in `lib/services/`
3. Create data models in `lib/models/`
4. Implement the Gemini API service
5. Build out the UI components in each screen
6. Add state management with Provider
7. Configure permissions for microphone access 