import 'package:flutter/material.dart';

class Preparing extends StatelessWidget {
  final String text;
  final double size;

  const Preparing({
    super.key,
    required this.text,
    this.size = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * size),
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
