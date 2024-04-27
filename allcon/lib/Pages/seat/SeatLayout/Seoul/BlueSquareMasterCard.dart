import 'package:allcon/Pages/Seat/SeatLayout/CustomFigure/Trapezoid.dart';
import 'package:allcon/Util/Theme.dart';
import 'package:flutter/material.dart';

class BlueSquareMasterCard extends StatelessWidget {
  const BlueSquareMasterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            stage(context),
            const SizedBox(height: 30),
            standing(context),
            const SizedBox(height: 30),
            second(context),
          ],
        ),
      ),
    );
  }
}

Widget stage(BuildContext context) {
  return Container(
    color: Colors.black54,
    width: 300,
    height: 30,
    child: const Center(
      child: Text(
        'STAGE',
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
    ),
  );
}

@override
Widget standing(BuildContext context) {
  return Column(
    children: [
      Row(
        children: [
          Container(
            width: 135,
            height: 120,
            color: Ground,
          ),
          const SizedBox(width: 40),
          Container(
            width: 135,
            height: 120,
            color: Ground,
          ),
        ],
      ),
      const SizedBox(height: 25),
      Row(
        children: [
          Container(
            width: 10,
            height: 50,
            color: secondFloor,
          ),
          const SizedBox(width: 25),
          Container(
            width: 85,
            height: 50,
            color: Ground,
          ),
          const SizedBox(width: 140),
          Container(
            width: 85,
            height: 50,
            color: Ground,
          ),
          const SizedBox(width: 25),
          Container(
            width: 10,
            height: 50,
            color: secondFloor,
          ),
        ],
      ),
    ],
  );
}

Widget second(BuildContext context) {
  return Row(
    children: [
      CustomPaint(
        painter: TrapezoidPainter(
          moveToX: 0.4,
          moveToY: 0,
          lineToX1: 1.05,
          lineToY1: 0,
          lineToX2: 1.05,
          lineToX3: 0.6,
          color: secondFloor,
        ),
        child: const SizedBox(
          width: 140,
          height: 50,
        ),
      ),
      const SizedBox(width: 15),
      CustomPaint(
        painter: TrapezoidPainter(
          moveToX: 0.18,
          moveToY: 0,
          lineToX1: 0.83,
          lineToY1: 0,
          lineToX2: 0.93,
          lineToX3: 0.1,
          color: secondFloor,
        ),
        child: const SizedBox(
          width: 140,
          height: 50,
        ),
      ),
      const SizedBox(width: 10),
      CustomPaint(
        painter: TrapezoidPainter(
          moveToX: 0,
          moveToY: 0,
          lineToX1: 0.62,
          lineToY1: 0,
          lineToX2: 0.42,
          color: secondFloor,
        ),
        child: const SizedBox(
          width: 140,
          height: 50,
        ),
      ),
    ],
  );
}
