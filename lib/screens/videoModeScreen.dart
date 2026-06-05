import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../controllers/VideoModeController.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoModeScreen extends GetView<VideoModeController> {

  VideoModeScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final currentVideo = controller.currentVideo;

        if (currentVideo == null) {
          return const Center(
            child: Text("Tidak ada video"),
          );
        }

        return Column(
          children: [
            // VIDEO PLAYER
            YoutubePlayer(
              controller: controller.youtubeController,
              aspectRatio: 16 / 9,
            ),

            const SizedBox(height: 16),

            Text(
              currentVideo.grade,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // NEXT PREV
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: controller.previousVideo,
                  child: const Text("Previous"),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: controller.nextVideo,
                  child: const Text("Next"),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // DATATABLE LIST VIDEO
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.videos.length,
                  itemBuilder: (context, index) {
                    final v = controller.videos[index];

                    return ListTile(
                      selected: index == controller.currentIndex.value,
                      title: Text(v.url),
                      onTap: () => controller.selectVideo(index),
                    );
                  },
                );
              }),
            ),
          ],
        );
      })
    );
  }


}