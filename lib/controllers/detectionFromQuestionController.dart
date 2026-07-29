import 'dart:io';

import 'package:camera/camera.dart';
import 'package:edu_app/models/luxandResponse.dart';
import 'package:edu_app/services/staffServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/postServices.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

class DetectionFromQuestionController extends GetxController {
  final String? exResult;
  final String? mode;
  final int? stage;
  final int? max_video;
  DetectionFromQuestionController({
    this.exResult,
    this.mode,
    this.stage,
    this.max_video,
  });

  final formKey = GlobalKey<FormState>();

  CameraController? cameraController;

  final isInitialized = false.obs;
  late final currentResult = (exResult ?? '').obs;
  late final dtMode = (mode ?? '').obs;
  late final currentIndex = (stage ?? 1).obs;
  late final maxVideo = (max_video ?? 1).obs;
  final luxandResult = ''.obs;
  final luxandError = ''.obs;
  final isUploading = false.obs;
  final resultValue = ''.obs;
  final resultStars = 0.obs;
  final resultSolution = ''.obs;
  final isSavingNext = false.obs;
  final savedLuxandExpression = ''.obs;
  final savedLuxandValue = 0.obs;
  final storage = StaffServices();

  @override
  void onInit() {
    super.onInit();

    print("init");
    print(currentResult);
    print(currentIndex);
    print(dtMode);
    print(maxVideo);

    initCamera();
  }

  String get targetEmotionImage {
    return imageForEmotion(currentResult.value);
  }

  String imageForEmotion(String emotion) {
    final normalized = emotion.trim().toLowerCase();

    switch (normalized) {
      case 'senang':
      case 'happy':
      case 'happiness':
        return 'assets/senang.png';
      case 'sedih':
      case 'sad':
      case 'sadness':
        return 'assets/sedih.png';
      case 'jijik':
      case 'disgust':
        return 'assets/jijik.png';
      case 'marah':
      case 'angry':
      case 'anger':
        return 'assets/marah.png';
      case 'takut':
      case 'fear':
        return 'assets/takut.png';
      case 'terkejut':
      case 'surprise':
        return 'assets/terkejut.png';
      case 'kaget':
        return 'assets/kaget.png';
      default:
        return 'assets/target.png';
    }
  }

  Future<void> captureAndUpload() async {
    if (isUploading.value) return;

    final path = await takePicture();

    if (path == null) {
      luxandResult.value = '';
      luxandError.value = 'Kamera belum siap. Coba lagi sebentar.';
      return;
    }

    await uploadToLuxand(File(path));
  }

  Future<void> uploadToLuxand(File file) async {
    try {
      isUploading.value = true;
      luxandResult.value = '';
      luxandError.value = '';
      resultValue.value = '';
      resultStars.value = 0;
      resultSolution.value = '';
      savedLuxandExpression.value = '';
      savedLuxandValue.value = 0;

      final LuxandResponse res = await ApiServiceForm.postLuxandFile(
        endpoint: 'photo/emotions',
        file: file,
        fieldName: 'photo',
        token: '155b714028c74f5d8e72d6e283b4f8af',
      );

      if (res.faces.isEmpty) {
        luxandError.value =
            'Wajah tidak terdeteksi. Pastikan wajahmu terlihat jelas.';
        return;
      }

      final face = res.faces.first;
      final expression = luxandExpressionToIndonesian(currentResult.value);
      luxandResult.value = expression;

      final value = emotionValue(expression, face.emotion);
      savedLuxandExpression.value = expression;
      savedLuxandValue.value = value;

      await saveExpressionResult(expression: expression, value: value);
    } catch (e) {
      debugPrint('Luxand upload error: $e');
      luxandError.value = 'Gagal memproses nilai ekspresi. Coba lagi.';
    } finally {
      isUploading.value = false;
    }
  }

  String luxandExpressionToIndonesian(String emotion) {
    final normalized = emotion.trim().toLowerCase();

    switch (normalized) {
      case 'happy':
      case 'happiness':
      case 'senang':
        return 'senang';
      case 'sad':
      case 'sadness':
      case 'sedih':
        return 'sedih';
      case 'disgust':
      case 'jijik':
        return 'jijik';
      case 'angry':
      case 'anger':
      case 'marah':
        return 'marah';
      case 'fear':
      case 'takut':
        return 'takut';
      case 'surprise':
      case 'terkejut':
      case 'kaget':
        return 'terkejut';
      case 'neutral':
      case 'netral':
        return 'netral';
      default:
        return normalized;
    }
  }

  int emotionValue(String targetEmotion, Map<String, dynamic> emotions) {
    final keys = luxandEmotionKeys(targetEmotion);
    num? rawValue;

    for (final key in keys) {
      final value = emotions[key];
      if (value is num) {
        rawValue = value;
        break;
      }

      if (value is String) {
        rawValue = num.tryParse(value);
        if (rawValue != null) break;
      }
    }

    var score = (rawValue ?? 0).toDouble();
    if (score <= 1) {
      score *= 100;
    }

    return score.round().clamp(0, 100).toInt();
  }

  List<String> luxandEmotionKeys(String emotion) {
    final normalized = emotion.trim().toLowerCase();

    switch (normalized) {
      case 'happy':
      case 'happiness':
      case 'senang':
        return ['happiness', 'happy', 'senang'];
      case 'sad':
      case 'sadness':
      case 'sedih':
        return ['sadness', 'sad', 'sedih'];
      case 'disgust':
      case 'jijik':
        return ['disgust', 'jijik'];
      case 'angry':
      case 'anger':
      case 'marah':
        return ['anger', 'angry', 'marah'];
      case 'fear':
      case 'takut':
        return ['fear', 'takut'];
      case 'surprise':
      case 'terkejut':
      case 'kaget':
        return ['surprise', 'terkejut', 'kaget'];
      case 'neutral':
      case 'netral':
        return ['neutral', 'netral'];
      default:
        return [normalized];
    }
  }

  Future<void> saveExpressionResult({
    required String expression,
    required int value,
  }) async {
    final response = await ApiServiceForm.postModel<Map<String, dynamic>>(
      endpoint: 'save-result-emo',
      data: {'expression': expression, 'value': value},
      fromJson: (json) {
        if (json is Map) {
          return Map<String, dynamic>.from(json);
        }

        return <String, dynamic>{};
      },
    );

    if (response.status != true) {
      luxandError.value = response.message;
      return;
    }

    final data = response.data ?? <String, dynamic>{};
    final result = mapValue(data['result']) ?? data;

    resultValue.value =
        firstValue(result, ['value', 'score', 'nilai']) ??
        firstValue(data, ['value', 'score', 'nilai', 'result']) ??
        '$value';
    resultStars.value = intValue(result['stars'] ?? data['stars']);
    resultSolution.value =
        firstValue(result, ['solution', 'label', 'message']) ??
        firstValue(data, ['solution', 'label', 'message']) ??
        response.message;
  }

  Map<String, dynamic>? mapValue(dynamic value) {
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }

    return null;
  }

  String? firstValue(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      final value = data[key];
      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString();
      }
    }

    return null;
  }

  int intValue(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  Future<String?> takePicture() async {
    try {
      if (cameraController == null || !cameraController!.value.isInitialized) {
        //debugPrint('❌ Camera not initialized');
        return null;
      }

      final XFile file = await cameraController!.takePicture();

      final File imageFile = File(file.path);

      final dir = await getTemporaryDirectory();
      final String newPath = '${dir.path}/image.png';

      final newFile = await imageFile.copy(newPath);

      //debugPrint('✅ Camera capture success: $newPath');

      return newFile.path;
    } catch (e) {
      //debugPrint('❌ Take picture failed: $e');
      return null;
    }
  }

  Future<void> initCamera() async {
    try {
      final cameras = await availableCameras();

      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await cameraController!.initialize();

      isInitialized.value = true;
    } catch (e) {
      debugPrint('Camera error: $e');
    }
  }

  Future<void> saveLuxand() async {
    final user = await storage.getStaff();
    final payload = {
      'user_id': user?.user_id ?? '',
      'stage': currentIndex.value,
      'mode': dtMode.value,
      'value': savedLuxandValue.value,
      'created_at': formattedDateTime(DateTime.now()),
    };

    final response = await ApiServiceForm.postModel<Map<String, dynamic>>(
      endpoint: 'save-luxand',
      data: payload,
      fromJson: (json) {
        if (json is Map) {
          return Map<String, dynamic>.from(json);
        }

        return <String, dynamic>{};
      },
    );

    if (response.status != true) {
      throw Exception(response.message);
    }
  }

  String formattedDateTime(DateTime dateTime) {
    final year = dateTime.year.toString().padLeft(4, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final second = dateTime.second.toString().padLeft(2, '0');

    return '$year-$month-$day $hour:$minute:$second';
  }

  Future<void> goToNextScreen(BuildContext context) async {
    if (isSavingNext.value) return;

    try {
      isSavingNext.value = true;
      luxandError.value = '';

      await saveLuxand();

      if (!context.mounted) return;

      if (currentIndex.value >= maxVideo.value) {
        context.go('/result', extra: {'mode': dtMode.value});
        return;
      }

      context.go(
        '/videoMode',
        extra: {'mode': dtMode.value, 'stage': currentIndex.value + 1},
      );
    } catch (e) {
      luxandError.value = 'Gagal menyimpan hasil Luxand. Coba lagi.';
    } finally {
      isSavingNext.value = false;
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}
