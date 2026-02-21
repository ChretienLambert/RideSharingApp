import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final IconData? prefix;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomInput({
    required this.controller,
    this.hintText,
    this.prefix,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validator,
      style: const TextStyle(
        fontSize: 16,
        color: Color(0xFF1F2937),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFF6B7280),
          fontSize: 16,
        ),
        prefixIcon: prefix != null
            ? Icon(prefix, color: const Color(0xFF6B7280))
            : null,
      ),
    );
  }
}
