import 'package:edu_app/models/videoModel.dart';
import 'package:flutter/material.dart';
import '../models/userModel.dart';
import '../widgets/genericDatatable.dart';
import 'package:get/get.dart';
import '../controllers/videoController.dart';

class VideoList extends StatelessWidget {

  VideoList({super.key});

  final VideoController controller = Get.put(VideoController());

 
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'List Video',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.videos.isEmpty) {
                  return const Center(
                    child: Text("Video kosong"),
                  );
                }

                return GenericDataTable<VideoModel>(
                  data: controller.videos,
                  columnTitles: const [
                    'Video ID',
                    'Url',
                    'Grade',
                  ],
                  extractRowValues: (video) => [
                    video.video_id ?? '',
                    video.url ?? '',
                    video.grade ?? ''
                  ],
                  //showDeleteButton: false,
                  //showDetailButton: false,
                  onDetailPressed: (video) {
                    print('DETAIL ${video.url}');
                  },

                  onDeletePressed: (video) async {
                    await controller.deleteVideo(context, video.video_id);
                    print('DELETE ${video.video_id}'); 
                  },
                );
              }) ,
          ],
        ),
      ),
    );
  }
}