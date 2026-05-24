// services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/apiResponse.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ApiService {
  static const String baseUrl =
      'https://apps.kartikasari.co.id/KSM_DMS/ApiKsmMobile';

  /// Method POST yang bisa langsung return model T
  static Future<ApiResponse<T>> postModel<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    //required T Function(Map<String, dynamic>) fromJson,
    required T Function(dynamic json) fromJson,
    Map<String, String>? headers,
  }) async {
    try {
      EasyLoading.show(status: 'Please Wait...');
      final url = Uri.parse('$baseUrl$endpoint');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', ...?headers},
        body: jsonEncode(data),
      );

      //print(response.body);

      final body = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse<T>.fromJson(body, fromJson);
      } else {
        throw Exception(
          body['message'] ?? 'Terjadi kesalahan saat mengirim data',
        );
      }
    } finally {
      EasyLoading.dismiss();
    }
  }
}


class ApiServiceForm {
  static const String baseUrl = 'http://localhost:8000/api/';

  static Future<ApiResponse<T>> postModel<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    //required T Function(Map<String, dynamic>) fromJson,
    required T Function(dynamic json) fromJson,
    Map<String, String>? headers,
  }) async {
    try {
      EasyLoading.show(status: 'Please Wait...');
      final url = Uri.parse('$baseUrl$endpoint');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          ...?headers,
        },
        body: data.map((key, value) => MapEntry(key, value.toString())),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse<T>.fromJson(body, fromJson);
      } else {
        throw Exception(
          body['message'] ?? 'Terjadi kesalahan saat mengirim data',
        );
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<ApiResponse<T>> getModel<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    //required T Function(Map<String, dynamic>) fromJson,
    required T Function(dynamic json) fromJson,
    Map<String, String>? headers,
  }) async {
    try {
      EasyLoading.show(status: 'Please Wait...');

      // ubah data jadi query string
      final uri = Uri.parse('$baseUrl$endpoint').replace(
        queryParameters: data.map(
          (key, value) => MapEntry(key, value.toString()),
        ),
      );

      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          ...?headers,
        },
      );

      final body = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse<T>.fromJson(body, fromJson);
      } else {
        throw Exception(
          body['message'] ?? 'Terjadi kesalahan saat mengambil data',
        );
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<ApiResponse<List<T>>> getList<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, String>? headers,
  }) async {

    try {

      EasyLoading.show(status: 'Please Wait...');

      final uri = Uri.parse('$baseUrl$endpoint').replace(
        queryParameters: data.map(
          (key, value) => MapEntry(
            key,
            value.toString(),
          ),
        ),
      );

      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          ...?headers,
        },
      );

      final body = jsonDecode(response.body);

      if (response.statusCode >= 200 &&
          response.statusCode < 300) {

        final List<dynamic> jsonList =
            body['data'] ?? [];

        return ApiResponse<List<T>>(
          status: body['status'] ?? false,
          message: body['message'] ?? '',
          data: jsonList
              .map((e) => fromJson(e))
              .toList(),
        );
      }

      throw Exception(
        body['message'] ??
        'Terjadi kesalahan saat mengambil data',
      );

    } finally {

      EasyLoading.dismiss();

    }
  }


}
