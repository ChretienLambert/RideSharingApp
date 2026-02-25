import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final IconData? prefix;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomInput({
    super.key,
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
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
        prefixIcon: prefix != null
            ? Icon(prefix, color: Theme.of(context).hintColor)
            : null,
      ),
    );
  }
}
