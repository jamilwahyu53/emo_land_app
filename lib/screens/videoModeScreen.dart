import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../controllers/videoModeController.dart';

class VideoModeScreen extends GetView<VideoModeController> {
  const VideoModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        
        //final video = controller.myVideo.value;
        //final isReady = controller.isVideoReady.value;

        //if (controller.isLoading.value  || video == null || !isReady ) {
        if(controller.isLoading.value == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        /*
        final currentId = controller.currentVideo!.video_id;
        final currentVideo = controller.currentVideo;

        if (currentVideo == null) {
          return const Center(
            child: Text(
              "Tidak ada video",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        */

        return SafeArea(
          child: Column(
            children: [
              // AREA VIDEO (90%)
              /*
              Expanded(
                flex: 9,
                child: Container(
                  width: double.infinity,
                  color: Colors.black,
                  child: Center(
                    child: YoutubePlayer(
                      controller: controller.youtubeController,
                      aspectRatio: 16 / 9,
                    ),
                  ),
                ),
              ),
              */
              // AREA TOMBOL (10%)
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: Colors.black,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: controller.previousVideo,
                          icon: const Icon(Icons.skip_previous),
                          label: const Text("Previous"),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: controller.nextVideo,
                          icon: const Icon(Icons.skip_next),
                          label: const Text("Next"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
            ],
          ),
        );
      }),
    );
  }
}