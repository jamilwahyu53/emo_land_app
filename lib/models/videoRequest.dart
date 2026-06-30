class VideoRequest<T> {
  final String grade;
  final int stage;

  VideoRequest({
    this.grade = "",
    this.stage = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'grade': grade,
      'stage': stage,
    };
  }

  factory VideoRequest.fromJson(Map<String, dynamic> json) {
    return VideoRequest(
      grade: json['grade'] ?? '',
      stage: json['stage'] ?? '',
    );
  }

}
