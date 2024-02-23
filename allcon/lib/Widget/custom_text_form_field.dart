import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final funValidator;
  final String? value;

  const CustomTextFormField({
    required this.hint,
    required this.funValidator,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value ?? "",
      validator: funValidator,
      decoration: InputDecoration(
        hintText: "$hint을 작성하세요.",
        enabledBorder: UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}
