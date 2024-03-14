import 'package:flutter/material.dart';

class Preparing extends StatelessWidget {
  final String text;

  const Preparing({required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          Text(
            'O',
            style: TextStyle(
              fontSize: 120.0,
              fontFamily: 'Cafe24Moyamoya',
              color: const Color(0xFFff66a1),
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            '$text',
            style: TextStyle(
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
