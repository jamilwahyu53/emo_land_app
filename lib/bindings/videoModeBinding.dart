import '../controllers/VideoModeController.dart';
import 'package:get/get.dart';

class VideoModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoModeController>(
      () => VideoModeController(),
      fenix: true,
    );
  }
}