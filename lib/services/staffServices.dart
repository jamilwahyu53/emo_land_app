import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/userModel.dart';

class StaffServices {
  final _storage = const FlutterSecureStorage();

  // Simpan model Staffs
  Future<void> saveStaff(UserModel staff) async {
    final jsonStr = jsonEncode(staff.toJson());
    await _storage.write(key: 'user_data', value: jsonStr);
  }

  // Ambil model Staffs
  Future<UserModel?> getStaff() async {
    final jsonStr = await _storage.read(key: 'user_data');
    if (jsonStr == null) return null;
    final jsonMap = jsonDecode(jsonStr);
    return UserModel.fromJson(jsonMap);
  }

  // Hapus
  Future<void> clear() async {
    await _storage.delete(key: 'user_data');
  }
}