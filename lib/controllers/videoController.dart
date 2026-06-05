import 'package:edu_app/models/videoModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../services/postServices.dart';
import 'package:edu_app/widgets/alertKsm.dart';
import 'package:go_router/go_router.dart';


class VideoController extends GetxController {

  var videos = <VideoModel>[].obs;
  var isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  final urlController = TextEditingController();
  final gradeController = TextEditingController();
  String videoIdEdit = "";

  bool _initialized = false;

  @override
  void onInit() {
    super.onInit();
    getVideo();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> initialize(String? videoId) async {
    if (_initialized) return;

    _initialized = true;

    if (videoId == null) return;

    await getVideoById(videoId);
  }



  Future<void> upsertVideo(BuildContext context, String? video_id) async {
    
    if (!formKey.currentState!.validate()) {
      return;
    }

    final url = urlController.text;
    final grade = gradeController.text;

    final req = VideoModel(video_id: video_id ?? "", url: url, grade: grade);
    
    try {
      final response = await ApiServiceForm.postModel(
        endpoint: 'upsert_video',
        data: req.toJson(),
        fromJson: (json) => VideoModel.fromJson(json),
      );

      if (response.status == true) {
        context.go('/listVideo');
        
      } else {
        AlertKsm.show(
          context: context,
          title: 'Info!',
          message: response.message,
          type: AlertType.info,
        );
      }
    } catch (e) {
      AlertKsm.show(
        context: context,
        title: 'Failed!',
        message: e.toString(),
        type: AlertType.warning,
      );
    } finally {}
    
  }

  Future<void> getVideo() async {
    
    final req = VideoModel();

    try {
      final response = await ApiServiceForm.getList(
        endpoint: 'get_video',
        data: req.toJson(),
        fromJson: (json) => VideoModel.fromJson(json),
      );

      if (response.status == true && response.data != null) {
        videos.value = response.data!;
      } else {
        print("Data kosong");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getVideoById(String video_id) async {
    
    final req = VideoModel(
      video_id: video_id
    );

    try {
      final response = await ApiServiceForm.postModel(
        endpoint: 'get_video_by_id',
        data: req.toJson(),
        fromJson: (json) => VideoModel.fromJson(json),
      );

      if (response.status == true && response.data != null) {
        videoIdEdit = video_id;
        urlController.text = response.data!.url;
        gradeController.text = response.data!.grade;
      } else {
        print("Data kosong");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteVideo(BuildContext context, String video_id) async {
    
    final req = VideoModel(video_id: video_id, url: "", grade: "");

    try {
      final response = await ApiServiceForm.postModel(
        endpoint: 'delete_video',
        data: req.toJson(),
        fromJson: (json) => VideoModel.fromJson(json),
      );

      if (response.status == true ) {
        final newList = List<VideoModel>.from(videos);
        newList.removeWhere((e) => e.video_id == video_id);

        videos.value = newList;
       
      } else {
        AlertKsm.show(
          context: context,
          title: 'Info!',
          message: response.message,
          type: AlertType.info,
        );
      }
    } catch (e) {
      AlertKsm.show(
          context: context,
          title: 'Error!',
          message: e.toString(),
          type: AlertType.error,
        );
    } finally {
      isLoading.value = false;
    }
  }

}
