import 'package:edu_app/screens/detectionMode.dart';
import 'package:edu_app/screens/forgotPass.dart';
import 'package:edu_app/screens/playForm.dart';
import 'package:edu_app/screens/playingMode.dart';
import 'package:edu_app/screens/upsertVideo.dart';
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