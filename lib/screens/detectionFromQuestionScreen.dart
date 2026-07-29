import 'package:camera/camera.dart';
import 'package:edu_app/controllers/detectionFromQuestionController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetectionFromQuestionScreen
    extends GetView<DetectionFromQuestionController> {
  DetectionFromQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg_detection.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),

                // TITLE
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "APA EKSPRESI DARI VIDEO TERSEBUT?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // TARGET EXPRESSION IMAGE
                Obx(() {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Image.asset(controller.targetEmotionImage, height: 150),
                        const SizedBox(height: 8),
                        Text(
                          controller.currentResult.value,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 20),

                // CAMERA AREA (LINGKARAN)
                Obx(() {
                  if (!controller.isInitialized.value ||
                      controller.cameraController == null ||
                      !controller.cameraController!.value.isInitialized) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipOval(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: CameraPreview(controller.cameraController!),
                        ),
                      ),

                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                      ),
                    ],
                  );
                }),

                const SizedBox(height: 10),

                // TIP BOX
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.camera_alt, size: 16),
                      SizedBox(width: 6),
                      Text("Pastikan wajahmu terlihat jelas"),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // START BUTTON
                Obx(() {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: controller.isUploading.value
                            ? [Colors.grey.shade400, Colors.grey.shade500]
                            : const [Color(0xFFFFD700), Color(0xFFFFA000)],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: controller.isUploading.value
                          ? null
                          : controller.captureAndUpload,
                      borderRadius: BorderRadius.circular(12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.camera_alt, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            controller.isUploading.value
                                ? "MEMPROSES"
                                : "MULAI",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 14),

                Obx(() {
                  if (controller.isUploading.value) {
                    return const SizedBox.shrink();
                  }

                  if (controller.luxandError.value.isNotEmpty) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        controller.luxandError.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  if (controller.resultValue.value.isEmpty &&
                      controller.resultSolution.value.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  final stars = controller.resultStars.value
                      .clamp(0, 5)
                      .toInt();

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "NILAI EKSPRESI",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.resultValue.value,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFA000),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            stars,
                            (_) => const Icon(
                              Icons.star,
                              color: Color(0xFFFFD700),
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.resultSolution.value,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 14),
                        InkWell(
                          onTap: controller.isSavingNext.value
                              ? null
                              : () => controller.goToNextScreen(context),
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 34,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: controller.isSavingNext.value
                                    ? [
                                        Colors.grey.shade400,
                                        Colors.grey.shade500,
                                      ]
                                    : const [
                                        Color(0xFF4FC3F7),
                                        Color(0xFF1976D2),
                                      ],
                              ),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  controller.isSavingNext.value
                                      ? "MENYIMPAN"
                                      : "NEXT",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
