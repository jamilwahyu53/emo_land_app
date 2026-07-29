import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:edu_app/models/luxandResponse.dart';
import 'package:edu_app/models/userModel.dart';
import 'package:edu_app/services/staffServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../models/emotionModel.dart';
import '../services/postServices.dart';
import 'package:edu_app/widgets/alertKsm.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';


class DetectionController extends GetxController {

  final formKey = GlobalKey<FormState>();

  CameraController? cameraController;

  final RxBool isInitialized = false.obs;

  final List<EmotionModel> emotions = const [
    EmotionModel(
      title: 'Senang',
      image: 'assets/happy.png',
    ),
    EmotionModel(
      title: 'Sedih',
      image: 'assets/sedih.png',
    ),
    EmotionModel(
      title: 'Terkejut',
      image: 'assets/kaget.png',
    ),
    EmotionModel(
      title: 'Marah',
      image: 'assets/marah.png',
    ),
  ];

  final Rx<EmotionModel> selectedEmotion =
    const EmotionModel(
      title: 'Senang',
      image: 'assets/happy.png',
    ).obs;

  void randomEmotion() {
    final random = Random();

    selectedEmotion.value =
        emotions[random.nextInt(emotions.length)];
  }

  @override
  void onInit() {
    super.onInit();

    randomEmotion();
    initCamera();
  }

Future<void> uploadToLuxand(BuildContext context, File file) async {
  try {
    final LuxandResponse res = await ApiServiceForm.postLuxandFile(
      endpoint: 'photo/emotions',
      file: file,
      fieldName: 'photo',
      token: '155b714028c74f5d8e72d6e283b4f8af',
    );

    final face = res.faces.first;

    final emotion = face.dominantEmotion;

    //debugPrint('Luxand response: $face');
    //debugPrint('Luxand emotion: $emotion');

    AlertKsm.show(
      context: context,
      title: 'Info!',
      message: emotion,
      type: AlertType.success,
    );

  } catch (e) {
    //debugPrint('Luxand upload error: $e');
    AlertKsm.show(
      context: context,
      title: 'Error!',
      message: "Exception Error",
      type: AlertType.error,
    );
  }
}

  Future<String?> takePicture() async {
    try {
      if (cameraController == null ||
          !cameraController!.value.isInitialized) {
        //debugPrint('❌ Camera not initialized');
        return null;
      }

      final XFile file =
          await cameraController!.takePicture();

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
      (camera) =>
          camera.lensDirection == CameraLensDirection.front,
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
  

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }

}
