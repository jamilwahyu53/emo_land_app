import 'package:flutter/material.dart';
import 'package:edu_app/screens/dashboard.dart';

/// Wrapper untuk Dashboard agar bisa menerima child dari GoRouter
class DashboardWrapper extends StatelessWidget {
  final Widget child;

  const DashboardWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Dashboard(
      content: child, // Kirim widget child ke Dashboard sebagai body
    );
  }
}