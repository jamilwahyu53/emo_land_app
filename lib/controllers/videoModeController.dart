import 'package:edu_app/models/videoModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';


class VideoModeController extends GetxController {

  final isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  final videos = <VideoModel>[].obs;

  final currentIndex = 0.obs;

  late YoutubePlayerController youtubeController;


  final isVideoReady = false.obs;

  VideoModel? get currentVideo {
    if (videos.isEmpty) return null;
    return videos[currentIndex.value];
  }

  
  @override
  void onInit() {
    super.onInit();

    videos.assignAll([
      VideoModel(
        video_id: "1",
        grade: "HARD",
        url: "https://www.youtube.com/watch?v=l08Zw-RY__Q&list=RDBBpIV9A1PXc&index=13&pp=8AUB",
      ),
      VideoModel(
        video_id: "1",
        grade: "HARD",
        url: "https://www.youtube.com/watch?v=YIza-jl2Kcs&list=RDBBpIV9A1PXc&index=14&pp=8AUB",
      )
    ]);

    _loadVideo(videos.first);

  }

  void _loadVideo(VideoModel video) {
    final videoId = YoutubePlayerController.convertUrlToId(video.url);

    if (videoId == null) return;

    youtubeController = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  void nextVideo() {
    if (currentIndex.value < videos.length - 1) {
      currentIndex.value++;

      final video = videos[currentIndex.value];
      final videoId = YoutubePlayerController.convertUrlToId(video.url);

      if (videoId != null) {
        youtubeController.loadVideoById(videoId: videoId);
      }
    }
  }

  void previousVideo() {
    if (currentIndex.value > 0) {
      currentIndex.value--;

      final video = videos[currentIndex.value];
      final videoId = YoutubePlayerController.convertUrlToId(video.url);

      if (videoId != null) {
        youtubeController.loadVideoById(videoId: videoId);
      }
    }
  }

  void selectVideo(int index) {
    currentIndex.value = index;

    final video = videos[index];
    final videoId = YoutubePlayerController.convertUrlToId(video.url);

    if (videoId != null) {
      youtubeController.loadVideoById(videoId: videoId);
    }
  }


  @override
  void onClose() {
    youtubeController.close();
    super.onClose();
  }

}