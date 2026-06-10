class VideoModel<T> {
  final String video_id;
  final String url;
  final String grade;
  final String title;
  final String result;

  VideoModel({
    this.video_id = "",
    this.url = "",
    this.grade = "",
    this.title = "",
    this.result = "",
  });

  Map<String, dynamic> toJson() {
    return {
      'video_id': video_id,
      'url': url,
      'grade': grade,
      'title': title,
      'result': result,
    };
  }

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      video_id: json['video_id'] ?? '',
      url: json['url'] ?? '',
      grade: json['grade'] ?? '',
      title: json['title'] ?? '',
      result: json['result'] ?? '',
    );
  }

}
