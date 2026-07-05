import 'package:edu_app/models/videoModel.dart';
import 'package:edu_app/models/videoRequest.dart';
import 'package:edu_app/services/postServices.dart';
import 'package:edu_app/widgets/alertKsm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';


class VideoModeController extends GetxController {

  final String? mode;
  final int? stage;
  VideoModeController({this.mode, this.stage});

  late final dtMode = (mode ?? '').obs;
  late  final currentIndex = (stage ?? 1).obs;
  late  final currentResult = ''.obs;

  final isLoading = true.obs;
  final formKey = GlobalKey<FormState>();
  final videos = <VideoModel>[].obs;

  late YoutubePlayerController youtubeController;
  final isVideoReady = false.obs;
  final Rxn<VideoModel> myVideo = Rxn<VideoModel>();

  VideoPlayerController? player;

  VideoModel? get currentVideo {
 
    if(myVideo.value == null) return null;
    return myVideo.value;
  }

  @override
  void onInit() {
    super.onInit();
        
    print("init");
    print(currentIndex);
    print(dtMode);

    GetVideoById(dtMode.value, currentIndex.value);
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
    isVideoReady.value = true;
    
  }

  void nextVideo() {
      currentIndex.value++;
      print(currentIndex.value);
      GetVideoById(dtMode.value, currentIndex.value);
 
  }

  void previousVideo() {
    if (currentIndex.value > 1) {
      currentIndex.value--;
      GetVideoById(dtMode.value, currentIndex.value);
    
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

  void GetVideoById(String mode, int stage) async {
    try {
      final req = VideoRequest(stage: stage, grade: mode);
      final response = await ApiServiceForm.postModel(
        endpoint: 'get_video_by_id',
        data: req.toJson(),
        fromJson: (json) => VideoModel.fromJson(json),
      );

      if (response.status == true) {
        print("resposne");
        print(response.data!.url);
        currentResult.value = response.data!.result;

        final myVideos = "http://192.168.0.3:8000/" + response.data!.url;

        player = VideoPlayerController.networkUrl(
          Uri.parse(myVideos),
        );

        await player!.initialize();

        await player!.setLooping(true);
        await player!.play();

        update();


      } else {
        print(response.message);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  @override
  void onClose() {
    player?.dispose();
    super.onClose();
  }

}