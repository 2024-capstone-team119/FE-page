import 'package:allcon/Pages/seat/SeatLayout/CustomFigure/Trapezoid.dart';
import 'package:allcon/utils/Colors.dart';
import 'package:flutter/material.dart';

class SongdoConvensia extends StatelessWidget {
  const SongdoConvensia({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: const Column(
          children: [
            Stage(),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Floor(),
            ),
          ],
        ),
      ),
    );
  }
}

class Stage extends StatelessWidget {
  const Stage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      width: 220,
      height: 28,
      child: const Center(
        child: Text(
          'STAGE',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class Floor extends StatelessWidget {
  const Floor({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            CustomPaint(
              painter: TrapezoidPainter(
                moveToX: 0,
                moveToY: 0.5,
                lineToX1: 1,
                lineToY1: 0.2,
                color: secondFloor,
              ),
              child: const SizedBox(
                width: 80,
                height: 120,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 140,
              height: 120,
              color: Ground,
            ),
            const SizedBox(width: 8),
            Container(
              width: 140,
              height: 120,
              color: Ground,
            ),
            const SizedBox(width: 8),
            CustomPaint(
              painter: TrapezoidPainter(
                moveToX: 0,
                moveToY: 0.2,
                lineToX1: 1,
                lineToY1: 0.5,
                color: secondFloor,
              ),
              child: const SizedBox(
                width: 80,
                height: 120,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              width: 80,
              height: 80,
              color: secondFloor,
            ),
            const SizedBox(width: 8),
            Container(
              width: 140,
              height: 80,
              color: Ground,
            ),
            const SizedBox(width: 8),
            Container(
              width: 140,
              height: 80,
              color: Ground,
            ),
            const SizedBox(width: 8),
            Container(
              width: 80,
              height: 80,
              color: secondFloor,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Container(
              width: 80,
              height: 50,
              color: secondFloor,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 140,
                  height: 30,
                  color: secondFloor,
                ),
                Container(
                  width: 60,
                  height: 20,
                  color: secondFloor,
                ),
              ],
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 140,
                  height: 30,
                  color: secondFloor,
                ),
                Container(
                  width: 60,
                  height: 20,
                  color: secondFloor,
                ),
              ],
            ),
            const SizedBox(width: 8),
            Container(
              width: 80,
              height: 50,
              color: secondFloor,
            ),
          ],
        ),
      ],
    );
  }
}
