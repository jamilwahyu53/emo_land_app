import 'package:edu_app/controllers/detectionFromQuestionController.dart';
import 'package:get/get.dart';

class DetectionFromQuestionBinding extends Bindings {
  final String? exResult;
  final String? mode;
  final int? stage;

  DetectionFromQuestionBinding({
    this.exResult,
    this.mode,
    this.stage,
  });

  @override
  void dependencies() {
    Get.lazyPut<DetectionFromQuestionController>(
      () => DetectionFromQuestionController(
        exResult: exResult,
        mode: mode,
        stage: stage,
      ),
      fenix: true,
    );
  }
}