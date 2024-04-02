import 'package:flutter/material.dart';

class GeneralTextField extends StatelessWidget {
  final String hintText;
  final bool isObsecure;
  final TextEditingController controller;
  const GeneralTextField({
    super.key,
    required this.isObsecure,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObsecure,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        border: InputBorder.none, // Remove border
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ), // Adjust padding
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
