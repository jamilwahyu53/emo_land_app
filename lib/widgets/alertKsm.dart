import 'package:flutter/material.dart';

class AlertKsm {
  static void show({
    required BuildContext context,
    required String message,
    required String title,
    String buttonText = "OK",
    VoidCallback? onPressed,
    // Menambahkan parameter tipe untuk menyesuaikan warna & ikon secara otomatis
    AlertType type = AlertType.success, 
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: _buildDialogContent(context, title, message, buttonText, onPressed, type),
        );
      },
    );
  }

  static Widget _buildDialogContent(
    BuildContext context, 
    String title, 
    String message, 
    String buttonText, 
    VoidCallback? onPressed,
    AlertType type,
  ) {
    final colorScheme = _getColors(type);
    final icon = _getIcon(type);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Ikon Status dengan Background Lingkaran
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme['iconBg'],
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: colorScheme['primary'],
              size: 40,
            ),
          ),
          const SizedBox(height: 24),
          
          // 2. Judul (Nexus Style)
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              fontFamily: 'IntroHeadR-Base',
              color: Color(0xFF0F172A), // Slate 900
            ),
          ),
          const SizedBox(height: 12),
          
          // 3. Pesan / Konten
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 'IntroHeadR-Base',
              color: Color(0xFF475569), // Slate 600
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          
          // 4. Tombol Utama (Nexus Blue)
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onPressed != null) onPressed();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A73E8), // Nexus Blue
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'IntroHeadR-Base',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper untuk menentukan warna berdasarkan tipe alert
  static Map<String, Color> _getColors(AlertType type) {
    switch (type) {
      case AlertType.success:
        return {'primary': const Color(0xFF22C55E), 'iconBg': const Color(0xFFDCFCE7)};
      case AlertType.error:
        return {'primary': const Color(0xFFEF4444), 'iconBg': const Color(0xFFFEE2E2)};
      case AlertType.warning:
        return {'primary': const Color(0xFFF59E0B), 'iconBg': const Color(0xFFFEF3C7)};
      case AlertType.info:
      default:
        return {'primary': const Color(0xFF1A73E8), 'iconBg': const Color(0xFFDBEAFE)};
    }
  }

  // Helper untuk menentukan ikon berdasarkan tipe alert
  static IconData _getIcon(AlertType type) {
    switch (type) {
      case AlertType.success: return Icons.check_circle_rounded;
      case AlertType.error: return Icons.error_rounded;
      case AlertType.warning: return Icons.warning_rounded;
      case AlertType.info:
      default: return Icons.info_rounded;
    }
  }
}

enum AlertType { info, success, warning, error }
