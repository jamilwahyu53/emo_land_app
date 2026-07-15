import 'package:edu_app/controllers/ResultController.dart';
import 'package:edu_app/controllers/detectionFromQuestionController.dart';
import 'package:edu_app/screens/ResultScreen.dart';

import '../bindings/detectionFromQuestion.dart';
import '../controllers/videoModeController.dart';

import '../bindings/videoModeBinding.dart';
import '../screens/detectionMode.dart';
import '../screens/forgotPass.dart';
import '../screens/playForm.dart';
import '../screens/playingMode.dart';
import '../screens/upsertVideo.dart';
import '../screens/videoModeScreen.dart';
import '../screens/detectionFromQuestionScreen.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../screens/login.dart';
import '../screens/registrasiStaff.dart';
import '../screens/videoList.dart';
import '../widgets/dashboardWrapper.dart';
import '../services/authServices.dart';
import '../services/staffServices.dart';
import '../controllers/videoController.dart';

final AuthServices authService = AuthServices();
final StaffServices storage = StaffServices();

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) async {
    final loggedIn = await authService.isLoggedIn();

    final isLoginRoute = state.matchedLocation == '/login';

    if (!loggedIn && !isLoginRoute) {
      return '/login';
    }

    if (loggedIn && isLoginRoute) {
      return '/playForm';
    }

    return null;
  },

  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return DashboardWrapper(child: child); // child valid
      },
      routes: [  
        GoRoute(
          path: '/registerStaff',
          builder: (context, state) => RegisterStaff(),
        ),
        GoRoute(
          path: '/forgotPass',
          builder: (context, state) => Forgotpass(),
        ),
        GoRoute(
          path: '/playForm',
          builder: (context, state) => PlayForm(),
        ),
        GoRoute(
          path: '/playingMode',
          builder: (context, state) => PlayingMode(),
        ),
        GoRoute(
          path: '/detectionMode',
          builder: (context, state) => DetectionMode(),
        ),
        GoRoute(
          path: '/upsertVideo',
          builder: (context, state) {
            final String? videoId = state.uri.queryParameters['video_id'];

            return UpsertVideo(
              videoId: videoId,
            );
          },
        ),
        GoRoute(
          path: '/listVideo',
          builder: (context, state) {
            final c = Get.isRegistered<VideoController>()
                ? Get.find<VideoController>()
                : Get.put(VideoController());

            if (c.videos.isEmpty) {
              c.getVideo();
            }

            return VideoList();
          },
        ),
        
        GoRoute(
          path: '/videoMode',
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>?;
            
            final mode = data?['mode'];
            final stage = data?['stage'] as int?;

            if (!Get.isRegistered<VideoModeController>()) {
              Get.lazyPut(() => 
                VideoModeController(
                  mode: mode,
                  stage: stage,
                ),
              );
            }

            return const VideoModeScreen();
          },
        ),
        
        GoRoute(
          path: '/detectionFromQuestion',
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>?;
            
            final exResult = data?['exResult'];
            final mode = data?['mode'];
            final stage = data?['stage'] as int?;
            final max_video = data?['max_video'] as int?;

            if (!Get.isRegistered<DetectionFromQuestionController>()) {
              Get.lazyPut(() => 
                DetectionFromQuestionController(
                  exResult: exResult,
                  mode: mode,
                  stage: stage,
                  max_video: max_video,
                ),
              );
            }

            return DetectionFromQuestionScreen();
          },
          /*
          path: '/detectionFromQuestion/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            DetectionFromQuestionBinding(id).dependencies();
            return DetectionFromQuestionScreen();
          },
          */
        ),
        GoRoute(
          path: '/result',
          builder: (context, state) {
            
            if (!Get.isRegistered<ResultController>()) {
              Get.lazyPut(() => 
                ResultController(),
              );
            }

            return ResultScreen();
          },
          
        ),
        GoRoute(
          path: '/logout',
          redirect: (context, state) async {
            await storage.clear();
            return '/login';
          },
        ),
      ],
    ),

  ],
);