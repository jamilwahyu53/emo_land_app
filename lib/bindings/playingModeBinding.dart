import 'package:edu_app/controllers/playingModeController.dart';
import 'package:get/get.dart';

class PlayingModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayingModeController>(
      () => PlayingModeController(),
      fenix: true,
    );
  }
}