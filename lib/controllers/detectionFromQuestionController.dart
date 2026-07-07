import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:edu_app/models/luxandResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../services/postServices.dart';
import 'package:edu_app/widgets/alertKsm.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';


class DetectionFromQuestionController extends GetxController {

  final String? exResult;
  final String? mode;
  final int? stage;
  final int? max_video;
  DetectionFromQuestionController({this.exResult, this.mode, this.stage, this.max_video});

  final formKey = GlobalKey<FormState>();

  CameraController? cameraController;

  final isInitialized = false.obs;
  late final currentResult =  (exResult ?? '').obs;
  late final dtMode = (mode ?? '').obs;
  late final currentIndex = (stage ?? 1).obs;
  late final maxVideo = (max_video ?? 1).obs;

  
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

Future<void> uploadToLuxand(BuildContext context, File file) async {
  try {
    final LuxandResponse res = await ApiServiceForm.postLuxandFile(
      endpoint: 'photo/emotions',
      file: file,
      fieldName: 'photo',
      token: '075d3aa7938c46b3aa2fa0cfd158a6c9',
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

  void goToNextScreen(BuildContext context) {
    final stage = currentIndex.value + 1;

    print("next stage");
    print(stage);
    print(maxVideo);
    print("end stage");

    if(stage > maxVideo.value){
      AlertKsm.show(
        context: context,
        title: 'Info!',
        message: "VIDEO MAX BOS",
        type: AlertType.info,
      );
    }
    else {
      context.go(
        '/videoMode',
        extra: {'mode': dtMode.value, 'stage': stage},
      );

      Get.delete<DetectionFromQuestionController>(force: true);
    }
  }
  

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }

}
