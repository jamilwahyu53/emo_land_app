import 'package:flutter/material.dart';

class GeneralField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final IconData icon;
  final double widthTe;
  final String hint;
  final ValueChanged<String>? onChanged;
  final bool isPassword;

  const GeneralField({
    super.key,
    this.controller,
    this.label = '',
    this.icon = Icons.adjust_sharp,
    this.widthTe = double.infinity,
    this.onChanged,
    this.hint = '',
    this.isPassword = false,
  });

  @override
  State<GeneralField> createState() => _GeneralFieldState();
}

class _GeneralFieldState extends State<GeneralField> {
  bool _obscureText = true;

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return '${widget.label} tidak boleh kosong';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 4),
              child: Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF475569), // Slate 600 (Nexus Style)
                  fontFamily: 'IntroHeadR-Base',
                ),
              ),
            ),
          SizedBox(
            width: widget.widthTe,
            child: TextFormField(
              controller: widget.controller,
              // Menggunakan state internal _obscureText untuk kontrol visibilitas
              obscureText: widget.isPassword ? _obscureText : false,
              onChanged: widget.onChanged,
              validator: _validator,
              keyboardType: widget.isPassword 
                            ? TextInputType.visiblePassword 
                            : TextInputType.emailAddress,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF0F172A), // Slate 900
                fontWeight: FontWeight.w500,
                fontFamily: 'IntroHeadR-Base',
              ),
              decoration: InputDecoration(
                hintText: widget.hint.isNotEmpty ? widget.hint : 'Masukkan ${widget.label}',
                hintStyle: const TextStyle(
                  color: Color(0xFF94A3B8), // Slate 400
                  fontWeight: FontWeight.normal,
                ),
                prefixIcon: Icon(
                  widget.icon,
                  size: 20,
                  color: const Color(0xFF64748B), // Slate 500
                ),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          size: 20,
                          color: const Color(0xFF64748B),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    : null,
                filled: true,
                // Warna background yang identik dengan desain Nexus (F1F5F9)
                fillColor: const Color(0xFFF1F5F9), 
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                // Border Default (Halus & Elegan)
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFE2E8F0), // Slate 200
                    width: 1.0,
                  ),
                ),
                // Border Saat Fokus (Nexus Blue)
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF1A73E8), // Nexus Blue
                    width: 2.0,
                  ),
                ),
                // Border Saat Error
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.redAccent,
                    width: 1.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
