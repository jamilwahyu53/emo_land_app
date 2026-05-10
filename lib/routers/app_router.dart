import 'package:edu_app/screens/forgotPass.dart';
import 'package:edu_app/screens/playForm.dart';
import 'package:edu_app/screens/playingMode.dart';
import 'package:go_router/go_router.dart';
import '../screens/login.dart';
import '../screens/registrasiStaff.dart';
import '../widgets/dashboardWrapper.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
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
      ],
    ),

  ],
);