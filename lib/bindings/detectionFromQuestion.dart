import 'package:edu_app/controllers/DetectionFromQuestion.dart';
import 'package:get/get.dart';

class DetectionFromQuestion extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetectionFromQuestion>(
      () => DetectionFromQuestion(),
      fenix: true,
    );
  }
}