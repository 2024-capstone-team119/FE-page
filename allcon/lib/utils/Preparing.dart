import 'package:flutter/material.dart';

class Preparing extends StatelessWidget {
  final String text;

  const Preparing({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          const Text(
            'O',
            style: TextStyle(
              fontSize: 120.0,
              fontFamily: 'Cafe24Moyamoya',
              color: Color(0xFFff66a1),
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
