import 'package:flutter/material.dart';
import 'dart:ui';
import '../models/bottomBar.dart';


class BottomNavBar extends StatelessWidget {
  final String currentRoute;
  final Function(String) onTap;
  
  /// List menu navigasi yang bisa dikustomisasi
  final List<NavItem> menuItems;

  const BottomNavBar({
    super.key,
    required this.currentRoute,
    required this.onTap,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 85,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(menuItems.length, (index) {
                return _buildNavItem(index, menuItems[index]);
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, NavItem item) {
    bool isActive = currentRoute == item.route;
    
    return GestureDetector(
      onTap: () => onTap(item.route),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFFEBF3FF) : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              isActive ? item.activeIcon : item.inactiveIcon,
              color: isActive ? const Color(0xFF1A73E8) : const Color(0xFF94A3B8),
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              color: isActive ? const Color(0xFF1A73E8) : const Color(0xFF94A3B8),
              fontFamily: 'Manrope',
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
