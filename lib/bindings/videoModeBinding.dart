import 'package:edu_app/controllers/videoModeController.dart';
import 'package:get/get.dart';

class HistoryBinding extends Bindings {
  final String? mode;
  final int? stage;

  HistoryBinding({
    this.mode,
    this.stage,
  });

  @override
  void dependencies() {
    Get.lazyPut<VideoModeController>(
      () => VideoModeController(
        mode: mode,
        stage: stage,
      ),
      fenix: true,
    );
  }
}