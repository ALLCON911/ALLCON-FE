import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final funValidator;
  final String? value;
  final controller;

  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.funValidator,
    this.value,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:
          hint == "비밀번호를 입력해주세요" || hint == '비밀번호를 다시 입력해주세요' ? true : false,
      controller: controller,
      initialValue: value,
      validator: funValidator,
      decoration: InputDecoration(
        hintText: hint,
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}
