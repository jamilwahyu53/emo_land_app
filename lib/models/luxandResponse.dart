import 'package:edu_app/models/luxandFace.dart';

class LuxandResponse {
  final String status;
  final List<LuxandFace> faces;

  LuxandResponse({
    required this.status,
    required this.faces,
  });

  factory LuxandResponse.fromJson(Map<String, dynamic> json) {
    return LuxandResponse(
      status: json['status'] ?? '',
      faces: (json['faces'] as List<dynamic>)
          .map((e) => LuxandFace.fromJson(e))
          .toList(),
    );
  }
}