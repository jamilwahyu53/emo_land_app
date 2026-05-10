import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'IntroHeadR-Base',
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      // Warna Primer Aplikasi (Nexus Blue)
      primaryColor: const Color(0xFF1A73E8),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF1A73E8),
        primary: const Color(0xFF1A73E8),
      ),
      
      // 3. Desain Input (TextField)
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFFF1F5F9), // Abu-abu sangat muda untuk isi input
        floatingLabelStyle: TextStyle(color: Color(0xFF1A73E8), fontWeight: FontWeight.w600),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        
        // Border saat tidak fokus (Sangat halus)
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
        ),
        
        // Border saat fokus (Biru Nexus)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Color(0xFF1A73E8), width: 2.0),
        ),
        
        // Border default
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        
        hintStyle: TextStyle(color: Color(0xFF94A3B8)),
        prefixIconColor: Color(0xFF64748B),
      ),

      // 4. Desain Tombol Utama (ElevatedButton)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A73E8), // Biru Nexus
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: const Color(0xFF1A73E8).withOpacity(0.4),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Roundness yang konsisten
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // 5. Tema Teks
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 28, 
          fontWeight: FontWeight.w800, 
          color: Color(0xFF0F172A),
          letterSpacing: -0.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 16, 
          color: Color(0xFF475569),
          height: 1.5,
        ),
      ),
    );
  }
}
