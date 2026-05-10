import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final double widthTe;
  final double heightTe;
  final ValueChanged<String>? onChanged;

  const PasswordField({
    super.key,
    this.controller,
    this.label = 'Password',
    this.heightTe = 60,
    this.widthTe = double.infinity,
    this.onChanged,
  });

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return '$label tidak boleh kosong';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: widthTe,
        height: heightTe,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(Icons.lock),
          ),
          validator: _validator,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
