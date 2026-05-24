class VideoModel<T> {
  final String video_id;
  final String url;
  final String grade;

  VideoModel({
    this.video_id = "",
    this.url = "",
    this.grade = "",
  });

  Map<String, dynamic> toJson() {
    return {
      'video_id': video_id,
      'url': url,
      'grade': grade,
    };
  }

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      video_id: json['video_id'] ?? '',
      url: json['url'] ?? '',
      grade: json['grade'] ?? '',
    );
  }

}
