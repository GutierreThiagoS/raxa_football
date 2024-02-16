import 'package:flutter/material.dart';

class OutlinedTextFiled extends StatefulWidget {
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
  State<OutlinedTextFiled> createState() => _OutlinedTextFiledState();
}

class _OutlinedTextFiledState extends State<OutlinedTextFiled> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: widget.suffixIcon != null ? Icon(widget.suffixIcon) : null,
        labelText: widget.labelText,
        hintText: widget.hintText,
        border: const OutlineInputBorder(),
      ),
      onChanged: widget.onChanged,
    );
  }
}
