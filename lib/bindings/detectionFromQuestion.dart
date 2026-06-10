import 'package:edu_app/controllers/DetectionFromQuestionController.dart';
import 'package:get/get.dart';

class DetectionFromQuestionBinding extends Bindings {
  final String videoId;

  DetectionFromQuestionBinding(this.videoId);

  @override
  void dependencies() {
    Get.lazyPut<DetectionFromQuestionController>(
      () => DetectionFromQuestionController(videoId),
      fenix: true,
    );
  }
}