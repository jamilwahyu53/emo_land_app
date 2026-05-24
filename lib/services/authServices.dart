import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthServices {
  final _storage = const FlutterSecureStorage();

  Future<bool> isLoggedIn() async {
    final data = await _storage.read(key: 'user_data');
    return data != null;
  }

}