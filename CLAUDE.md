# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter mobile application for audio transcription and text analysis using Google's Gemini API. The app allows users to record audio, transcribe it, and perform various text analyses including tone analysis, summary generation, and key points extraction.

**Tech Stack:**
- **Flutter** - Cross-platform mobile framework
- **Dart SDK**: >=3.1.0 <4.0.0
- **Google Generative AI** - Gemini API for transcription and analysis
- **Provider** - State management
- **Record** - Audio recording functionality

## Development Commands

```bash
# Install dependencies
flutter pub get

# Run the application
flutter run

# Run on specific device
flutter run -d device_id

# Build for production
flutter build apk      # Android APK
flutter build appbundle # Android App Bundle
flutter build ios      # iOS (requires macOS)
flutter build web      # Web version

# Clean and rebuild
flutter clean
flutter pub get

# Code quality
flutter analyze        # Static analysis
flutter format .       # Format code
```

## Architecture Overview

The app follows a clean architecture pattern:

```
lib/
├── main.dart              # App entry point
├── models/               # Data models
│   └── analysis_result.dart  # Analysis response model
├── screens/              # UI screens
│   ├── analysis_screen.dart  # Tabbed analysis results
│   ├── dictation_screen.dart # Audio recording/transcription
│   └── settings_screen.dart  # App settings
└── services/             # Business logic
    └── gemini_api_service.dart # Gemini API integration
```

## Key Features & Implementation Status

✅ **Implemented:**
- Audio recording with visual feedback
- Audio transcription via Gemini API
- Text analysis (tone, summary, key points)
- Tabbed interface for analysis results
- Dark theme UI
- Basic navigation between screens

🚧 **TODO:**
- Move API key from hardcoded value to secure storage
- Add error handling for network failures
- Implement settings persistence
- Add audio file size/duration limits
- Create unit and widget tests

## API Integration

The app uses Google's Gemini API through the `google_generative_ai` package:

### Audio Transcription
- Model: `gemini-1.5-flash`
- Accepts audio files via `DataPart`
- Returns transcribed text

### Text Analysis
- Analyzes transcribed text for:
  - Overall tone
  - Summary
  - Key points
- Returns structured `AnalysisResult` object

## Security Considerations

**CRITICAL**: The API key is currently hardcoded in `lib/services/gemini_api_service.dart:8`. This must be moved to:
1. Environment variables using `--dart-define`
2. Secure storage using `flutter_secure_storage`
3. Or a separate config file that's gitignored

## UI/UX Guidelines

- **Theme**: Dark theme with black background
- **AppBar**: Dark colored (`Color(0xFF1A1A1A)`)
- **Accent**: Blue colors for interactive elements
- **Text**: White text on dark backgrounds
- **Icons**: Using Iconsax icon library

## Common Development Tasks

### Adding New Analysis Types
1. Update `AnalysisResult` model in `models/analysis_result.dart`
2. Modify `analyzeText` prompt in `services/gemini_api_service.dart`
3. Add new tab in `screens/analysis_screen.dart`

### Handling Permissions
The app uses `permission_handler` for microphone access:
- Permissions are requested in `dictation_screen.dart`
- Always check permission status before recording

### State Management
Currently using `Provider` for state management. Audio recording state is managed locally in `DictationScreen` using `StatefulWidget`.

## Testing

No tests currently exist. To add tests:

```bash
# Create test directory structure
mkdir test
mkdir test/models
mkdir test/services
mkdir test/screens

# Run tests
flutter test

# Run with coverage
flutter test --coverage
```

## Build Configuration

- Minimum SDK versions defined in `android/app/build.gradle`
- iOS deployment target in `ios/Runner.xcodeproj`
- Web build outputs to `build/web/`

## Known Issues

1. Empty duplicate directory structure at `transcription_app/`
2. No offline support for transcription
3. No audio file caching mechanism
4. Settings screen not implemented