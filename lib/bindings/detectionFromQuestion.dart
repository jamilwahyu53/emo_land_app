import 'package:edu_app/controllers/detectionFromQuestionController.dart';
import 'package:get/get.dart';

class DetectionFromQuestionBinding extends Bindings {
  final String? exResult;
  final String? mode;
  final int? stage;
  final int? max_video;

  DetectionFromQuestionBinding({
    this.exResult,
    this.mode,
    this.stage,
    this.max_video,
  });

  @override
  void dependencies() {
    Get.lazyPut<DetectionFromQuestionController>(
      () => DetectionFromQuestionController(
        exResult: exResult,
        mode: mode,
        stage: stage,
        max_video: max_video,
      ),
      fenix: true,
    );
  }
}