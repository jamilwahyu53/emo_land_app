import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final AlignmentGeometry alignment;

  const TextLink({
    super.key,
    required this.text,
    required this.onTap,
    this.color = const Color(0xFF1A73E8), // Nexus Blue
    this.fontSize = 14,
    this.fontWeight = FontWeight.w700,
    this.alignment = Alignment.centerRight,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: 'IntroHeadR-Base',
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}

// Cara Penggunaan untuk "Lupa Kata Sandi?":
// TextLink(
//   text: 'Lupa Kata Sandi?',
//   onTap: () => print('Lupa sandi diklik'),
// )

// Cara Penggunaan untuk "Lihat Semua":
// TextLink(
//   text: 'Lihat Semua',
//   alignment: Alignment.centerLeft, // Sesuaikan posisi
//   onTap: () => print('Lihat semua diklik'),
// )