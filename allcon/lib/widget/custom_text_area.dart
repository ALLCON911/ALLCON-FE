import 'package:flutter/material.dart';

class CustomTextArea extends StatelessWidget {
  final String hint;
  final funValidator;
  final TextEditingController controller;

  const CustomTextArea({
    super.key,
    required this.hint,
    required this.funValidator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 18,
      controller: controller,
      validator: funValidator,
      decoration: InputDecoration(
        hintText: "$hint을 작성하세요.",
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}
