// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ProjectTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  bool isPassword;
  final Function(String onChanged)? onChanged;
  final TextInputType? keyboardType;
  ProjectTextField({
    super.key,
    this.controller,
    this.isPassword = false,
    this.onChanged,
    this.keyboardType,
    required this.prefixIcon,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  State<ProjectTextField> createState() => _ProjectTextFieldState();
}
class _ProjectTextFieldState extends State<ProjectTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        cursorRadius: const Radius.circular(20),
        onChanged: widget.onChanged,
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Icon(widget.prefixIcon),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
