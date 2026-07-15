class SaveResultModel<T> {
  final String user_id;
  final int result;

  SaveResultModel({
    this.user_id = "",
    this.result = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'result': result,
    };
  }

  factory SaveResultModel.fromJson(Map<String, dynamic> json) {
    return SaveResultModel(
      user_id: json['user_id'] ?? '',
      result: json['result'] ?? 0,
    );
  }

}
