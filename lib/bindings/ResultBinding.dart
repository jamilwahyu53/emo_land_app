import 'package:edu_app/controllers/ResultController.dart';
import 'package:get/get.dart';

class ResultBinding extends Bindings {
  
  ResultBinding();

  @override
  void dependencies() {
    Get.lazyPut<ResultController>(
      () => ResultController(),
      fenix: true,
    );
  }
}