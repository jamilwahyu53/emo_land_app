import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/postServices.dart';
import '../services/staffServices.dart';

class ResultController extends GetxController {
  final String? mode;
  ResultController({this.mode});

  final isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final fullName = ''.obs;
  final averageStars = ''.obs;
  final totalStage = 0.obs;
  final stages = <Map<String, dynamic>>[].obs;
  final storage = StaffServices();
  late final currentMode = (mode ?? '').obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    isLoading.value = true;

    try {
      final user = await storage.getStaff();
      fullName.value = user?.full_name ?? '-';

      if (user != null) {
        await getLuxandAverage(user.user_id);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getLuxandAverage(String userId) async {
    final response = await ApiServiceForm.postModel<Map<String, dynamic>>(
      endpoint: 'get-luxand-average',
      data: {'user_id': userId, 'mode': currentMode.value},
      fromJson: (json) {
        if (json is Map) {
          return Map<String, dynamic>.from(json);
        }

        return <String, dynamic>{};
      },
    );

    if (response.status != true) {
      return;
    }

    final data = response.data ?? <String, dynamic>{};
    averageStars.value = (data['average_value'] ?? '-').toString();
    totalStage.value = intValue(data['total_stage']);

    final stageList = data['stages'];
    if (stageList is List) {
      stages.assignAll(
        stageList
            .whereType<Map>()
            .map((stage) => Map<String, dynamic>.from(stage))
            .toList(),
      );
    }
  }

  int intValue(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
