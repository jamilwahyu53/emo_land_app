import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final IconData? icon;
  final double widthBtn;
  final double heightBtn;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.icon,
    this.textColor,
    this.widthBtn = 0,
    this.heightBtn = 56,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthBtn,
      height: heightBtn,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A73E8), // Biru Nexus
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: const Color(0xFF1A73E8).withOpacity(0.4),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Roundness yang konsisten
          ),
          // Animasi transisi saat ditekan
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        icon: icon != null ? Icon(icon) : const SizedBox(),
        label: Text(label, style: const TextStyle(fontSize: 16, 
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,)),
      ),
    );
  }
}
