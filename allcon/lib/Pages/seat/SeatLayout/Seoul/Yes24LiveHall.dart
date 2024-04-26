import 'package:allcon/Pages/Seat/SeatLayout/CustomFigure/Trapezoid.dart';
import 'package:allcon/Util/Theme.dart';
import 'package:flutter/material.dart';

class Yes24LiveHall extends StatelessWidget {
  const Yes24LiveHall({super.key});

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
            first(context),
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
    width: 330,
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
Widget first(BuildContext context) {
  return Column(
    children: [
      Row(
        children: [
          CustomPaint(
            painter: TrapezoidPainter(
              moveToX: 0.2,
              moveToY: 0,
              lineToX1: 1,
              lineToY1: 0,
              lineToX3: 0.1,
              color: Ground,
            ),
            child: const SizedBox(
              width: 100,
              height: 80,
            ),
          ),
          const SizedBox(width: 20),
          Container(
            width: 100,
            height: 80,
            color: Ground,
          ),
          const SizedBox(width: 20),
          CustomPaint(
            painter: TrapezoidPainter(
              moveToX: 0,
              moveToY: 0,
              lineToX1: 0.8,
              lineToY1: 0,
              lineToX2: 0.9,
              color: Ground,
            ),
            child: const SizedBox(
              width: 100,
              height: 80,
            ),
          ),
        ],
      ),
      const SizedBox(height: 25),
      Row(
        children: [
          Container(
            width: 90,
            height: 50,
            color: Ground,
          ),
          const SizedBox(width: 140),
          Container(
            width: 90,
            height: 50,
            color: Ground,
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
          lineToX3: 0.7,
          color: oneFloor,
        ),
        child: const SizedBox(
          width: 140,
          height: 50,
        ),
      ),
      const SizedBox(width: 20),
      CustomPaint(
        painter: TrapezoidPainter(
          moveToX: 0.1,
          moveToY: 0,
          lineToX1: 0.93,
          lineToY1: 0,
          lineToX2: 1.03,
          lineToX3: 0,
          color: oneFloor,
        ),
        child: const SizedBox(
          width: 140,
          height: 50,
        ),
      ),
      const SizedBox(width: 15),
      CustomPaint(
        painter: TrapezoidPainter(
          moveToX: 0,
          moveToY: 0,
          lineToX1: 0.62,
          lineToY1: 0,
          lineToX2: 0.32,
          color: oneFloor,
        ),
        child: const SizedBox(
          width: 140,
          height: 50,
        ),
      ),
    ],
  );
}
