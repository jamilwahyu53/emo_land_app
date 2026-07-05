import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import '../controllers/videoModeController.dart';

class VideoModeScreen extends GetView<VideoModeController> {
  const VideoModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        
        if(controller.isLoading.value == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
         return Stack(
            children: [

              /// Video
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: controller.player!.value.size.width,
                  height: controller.player!.value.size.height,
                  child: VideoPlayer(controller.player!),
                ),
              ),
            ),

            /// Previous
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: controller.previousVideo,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.transparent,
                ),
              ),
            ),

            /// Next
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                //onTap: controller.nextVideo,
                onTap: () {
                  context.go(
                    '/detectionFromQuestion',
                     extra: {
                      'exResult': controller.currentResult.value,
                      'mode': controller.dtMode.value,
                      'stage': controller.currentIndex.value,
                    },
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.transparent,
                ),
              ),
            ),

              
            ],
         );
      }),
    );
  }
}