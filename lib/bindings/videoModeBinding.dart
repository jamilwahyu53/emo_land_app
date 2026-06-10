import '../controllers/VideoModeController.dart';
import 'package:get/get.dart';

class VideoModeBinding extends Bindings {

  final String videoId;

  VideoModeBinding(this.videoId);

  @override
  void dependencies() {
    Get.lazyPut<VideoModeController>(
      () => VideoModeController(videoId),
      fenix: true,
    );
  }
}