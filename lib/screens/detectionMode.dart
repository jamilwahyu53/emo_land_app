 import 'dart:io';

import 'package:camera/camera.dart';
import 'package:edu_app/controllers/detectionController.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/widgets/buttonKsm.dart';
import 'package:edu_app/widgets/generalField.dart';
import 'package:edu_app/widgets/textLink.dart';
import 'package:go_router/go_router.dart';
import '../controllers/loginController.dart';
import 'package:get/get.dart';

class DetectionMode extends StatelessWidget {

  DetectionMode({super.key}); 

  final DetectionController controller = Get.put(
    DetectionController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: 
      
      Container(
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
                      "AYO TUNJUKAN EKSPRESIMU",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // CHARACTER IMAGE
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Obx(() {
                      final emotion =
                          controller.selectedEmotion.value;

                        return Column(
                          children: [
                            Image.asset(
                              emotion.image,
                              height: 160,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              emotion.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        );
                    })
                  ),

                  const SizedBox(height: 20),

                  // INFO CARD
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Text(
                      "Lihat wajah ini, lalu tirukan dengan wajahmu",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // CAMERA AREA (LINGKARAN)
                  Obx(() {
                    if (!controller.isInitialized.value ||
                        controller.cameraController == null ||
                        !controller.cameraController!.value.isInitialized) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipOval(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: CameraPreview(
                              controller.cameraController!,
                            ),
                          ),
                        ),

                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFD700), Color(0xFFFFA000)],
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
                      onTap: () async {
                        final path = await controller.takePicture();

                        if (path == null) return;

                        final file = File(path);

                        await controller.uploadToLuxand(context, file);
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.camera_alt, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            "MULAI",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    )
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
        ),
      ),
    );
  }
}
