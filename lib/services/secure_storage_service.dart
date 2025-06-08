import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Service for securely storing and retrieving sensitive data like API keys
class SecureStorageService {
  final _storage = const FlutterSecureStorage();
  static const _apiKeyStorageKey = 'gemini_api_key';

  /// Saves the API key to secure storage
  Future<void> saveApiKey(String apiKey) async {
    await _storage.write(key: _apiKeyStorageKey, value: apiKey);
  }

  /// Retrieves the API key from secure storage
  /// Returns null if no key is stored
  Future<String?> getApiKey() async {
    return await _storage.read(key: _apiKeyStorageKey);
  }

  /// Deletes the API key from secure storage
  Future<void> deleteApiKey() async {
    await _storage.delete(key: _apiKeyStorageKey);
  }

  /// Checks if an API key is stored
  Future<bool> hasApiKey() async {
    final key = await getApiKey();
    return key != null && key.isNotEmpty;
  }
} 