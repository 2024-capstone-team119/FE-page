import 'package:flutter/material.dart';

class HallPreparing extends StatelessWidget {
  const HallPreparing({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 300.0,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 40.0),
            Text(
              'O',
              style: TextStyle(
                fontSize: 100.0,
                fontFamily: 'Cafe24Moyamoya',
                color: Color(0xFFff66a1),
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              '좌석배치도 준비 중입니다.',
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
