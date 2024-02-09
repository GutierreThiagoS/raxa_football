import 'package:flutter/material.dart';

class OutlinedTextFiled extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function(String) onChanged;
  const OutlinedTextFiled({
    super.key,
    required this.labelText,
    required this.onChanged,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}
