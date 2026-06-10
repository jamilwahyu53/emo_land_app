import '../controllers/VideoModeController.dart';
import 'package:get/get.dart';

class VideoModeBinding extends Bindings {

  final String videoId;

  VideoModeBinding(this.videoId);

  @override
  void dependencies() {
    // pastikan controller lama dibuang dulu
    if (Get.isRegistered<VideoModeController>()) {
      Get.delete<VideoModeController>(force: true);
    }

    Get.lazyPut<VideoModeController>(
      () => VideoModeController(videoId),
    );
  }
}