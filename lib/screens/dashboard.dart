import 'package:edu_app/screens/detectionMode.dart';
import 'package:edu_app/screens/playForm.dart';
import 'package:edu_app/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/bottomBar.dart';
import 'package:edu_app/services/staffServices.dart';


class Dashboard extends StatefulWidget {
  final Widget? content;

  const Dashboard({super.key, this.content});

  @override
  _DashboardState createState() => _DashboardState();
  
}

class _DashboardState extends State<Dashboard> {
  
  String currentRoute = "/playForm";

  final List<Widget> pages = [
    DetectionMode(),
    PlayForm(),
  ];

  final List<NavItem> menuItems = [
    NavItem(
      activeIcon: Icons.home,
      inactiveIcon: Icons.home_outlined,
      label: 'Home',
      route: '/playForm',
    ),
    NavItem(
      activeIcon: Icons.play_arrow,
      inactiveIcon: Icons.play_arrow_outlined,
      label: 'List Video',
      route: '/listVideo',
    ),
    NavItem(
      activeIcon: Icons.person,
      inactiveIcon: Icons.person_outline,
      label: 'List User',
      route: '/registerStaff',
    ),
    NavItem(
      activeIcon: Icons.power_off,
      inactiveIcon: Icons.power_off_outlined,
      label: 'Logout',
      route: '/logout',
    ),
  ];

  void onTabChanged(String route) {
    setState(() {
      currentRoute = route;
      context.go(route);
    });
  }

  final storage = StaffServices();
  int userAdmin = 0;

  Widget _buildDrawerHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 211, 175, 175),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'KSM DMS',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1A73E8),
              fontFamily: 'IntroHeadR-Base',
              letterSpacing: -0.5,
            ),
          ),
          Text(
            'v1.0.4',
            style: TextStyle(
              fontSize: 12,
              color: const Color(0xFF64748B).withOpacity(0.7),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadUser() async {
    final user = await storage.getStaff();
    setState(() {
      userAdmin = user?.user_id == "admin" ? 1 : 0;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Slate 50 background
      body: widget.content ,
      bottomNavigationBar: userAdmin == 1 ? BottomNavBar(
        currentRoute: currentRoute,
        onTap: (route) => onTabChanged(route),
        menuItems: menuItems,
      ) : null,
    );
  }
}
