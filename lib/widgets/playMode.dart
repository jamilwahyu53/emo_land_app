import 'package:edu_app/widgets/alertKsm.dart';
import 'package:flutter/material.dart';

class PlayMode {
  static void show({
    required BuildContext context,
    required String message,
    required String title,

    String primaryButtonText = "OK",
    String secondaryButtonText = "Batal",

    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,

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
          child: _buildDialogContent(
            context,
            title,
            message,
            primaryButtonText,
            secondaryButtonText,
            onPrimaryPressed,
            onSecondaryPressed,
            type,
          ),
        );
      },
    );
  }

  static Widget _buildDialogContent(
    BuildContext context,
    String title,
    String message,
    String primaryButtonText,
    String secondaryButtonText,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    AlertType type,
  ) {
    final colorScheme = _getColors(type);
    final icon = _getIcon(type);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              fontFamily: 'IntroHeadR-Base',
              color: Color(0xFF0F172A),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 'IntroHeadR-Base',
              color: Color(0xFF475569),
              height: 1.5,
            ),
          ),

          const SizedBox(height: 32),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onSecondaryPressed?.call();
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    side: const BorderSide(
                      color: Color(0xFFCBD5E1),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    secondaryButtonText,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'IntroHeadR-Base',
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onPrimaryPressed?.call();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A73E8),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    primaryButtonText,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'IntroHeadR-Base',
                    ),
                  ),
                ),
              ),
            ],
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