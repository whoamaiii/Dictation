class AnalysisResult {
  final String summary;
  final String sentiment;
  final String keyPhrases;
  final String topics;

  AnalysisResult({
    required this.summary,
    required this.sentiment,
    required this.keyPhrases,
    required this.topics,
  });

  factory AnalysisResult.fromJson(Map<String, dynamic> json) {
    return AnalysisResult(
      summary: json['summary'] ?? 'No summary provided.',
      sentiment: json['sentiment'] ?? 'No sentiment analysis.',
      keyPhrases: json['key_phrases'] ?? 'No key phrases identified.',
      topics: json['topics'] ?? 'No topics identified.',
    );
  }
} 