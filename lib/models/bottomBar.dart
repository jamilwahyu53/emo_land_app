import 'package:flutter/material.dart';

class NavItem {
  final String label;
  final String route;
  final IconData inactiveIcon;
  final IconData activeIcon;

  NavItem({
    required this.label,
    required this.inactiveIcon,
    required this.activeIcon,
    required this.route,
  });
}