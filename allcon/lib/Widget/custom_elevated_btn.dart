import 'package:flutter/material.dart';

class CustomElevatedBtn extends StatelessWidget {
  final String text;
  final funPageRoute;

  const CustomElevatedBtn({super.key, required this.text, required this.funPageRoute});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: funPageRoute,
      child: Text(text),
    );
  }
}
