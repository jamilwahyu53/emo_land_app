import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Dashboard extends StatefulWidget {
  final Widget? content;
  const Dashboard({super.key, this.content});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _currentRoute = 'Beranda';
  String _currentTitle = 'Beranda';


  Widget _buildDrawerHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
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

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Slate 50 background
      /*
      // 1. Custom AppBar (Nexus Style)
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          _currentTitle,
          style: const TextStyle(
            color: Color(0xFF1A73E8),
            fontWeight: FontWeight.w800,
            fontFamily: 'IntroHeadR-Base',
            fontSize: 20,
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: Color(0xFF1A73E8)),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),

      // 2. Custom Drawer (Nexus Sidebar)
      
      drawer: Drawer(
        width: 280,
        backgroundColor: Colors.white,
        elevation: 0,
        child: Column(
          children: [
            // Header: User Profile / App Info
            _buildDrawerHeader(),
            
            const SizedBox(height: 12),
            
            // Menu Items List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: _menuItems.map((item) => _buildMenuItem(item)).toList(),
              ),
            ),

            // Footer (Versi / App Name)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Divider(color: Color(0xFFF1F5F9)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.admin_panel_settings, color: Color(0xFF64748B)),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jamil Wahyu',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            'Administrator',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      */

      body: widget.content ,
    );
  }
}
