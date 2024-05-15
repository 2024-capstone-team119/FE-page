import 'package:allcon/pages/review/layout/customFigure/Trapezoid.dart';
import 'package:allcon/utils/Colors.dart';
import 'package:flutter/material.dart';

class SongdoConvensia extends StatelessWidget {
  const SongdoConvensia({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
              SizedBox(height: 30),
            ],
          ),
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
                child: Padding(
                  padding: EdgeInsets.fromLTRB(19.0, 65.0, 0.0, 0.0),
                  child: Text(
                    '1구역',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 140,
              height: 120,
              color: Ground,
              child: const Center(
                child: Text(
                  '2구역',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 140,
              height: 120,
              color: Ground,
              child: const Center(
                child: Text(
                  '3구역',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
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
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 65.0, 0.0, 0.0),
                  child: Text(
                    '4구역',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
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
              child: const Center(
                child: Text(
                  '5구역',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 140,
              height: 80,
              color: Ground,
              child: const Center(
                child: Text(
                  '6구역',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 140,
              height: 80,
              color: Ground,
              child: const Center(
                child: Text(
                  '7구역',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 80,
              height: 80,
              color: secondFloor,
              child: const Center(
                child: Text(
                  '8구역',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
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
              child: const Center(
                child: Text(
                  '9구역',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 140,
                  height: 30,
                  color: secondFloor,
                  child: const Center(
                    child: Text(
                      '10구역',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
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
                  child: const Center(
                    child: Text(
                      '11구역',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
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
              child: const Center(
                child: Text(
                  '12구역',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
