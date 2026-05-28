class LuxandFace {
  final String dominantEmotion;
  final Map<String, dynamic> emotion;

  LuxandFace({
    required this.dominantEmotion,
    required this.emotion,
  });

  factory LuxandFace.fromJson(Map<String, dynamic> json) {
    return LuxandFace(
      dominantEmotion: json['dominant_emotion'] ?? '',
      emotion: json['emotion'] ?? {},
    );
  }
}