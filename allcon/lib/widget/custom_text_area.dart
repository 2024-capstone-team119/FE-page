import 'package:flutter/material.dart';

class CustomTextArea extends StatelessWidget {
  final String hint;
  final funValidator;

  const CustomTextArea({required this.hint, required this.funValidator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 15,
      validator: funValidator,
      decoration: InputDecoration(
        hintText: "$hint을 작성하세요.",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
