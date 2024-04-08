import 'package:allcon/Pages/Seat/SeatLayout/CustomFigure/TrapezoidCurve.dart';
import 'package:allcon/Util/Theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class OlympicChaejo extends StatelessWidget {
  const OlympicChaejo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          firstFloor(context),
          // Ablock(context),
        ],
      ),
    );
  }

  Widget firstFloor(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 600,
        height: 600,
        child: Stack(
          children: List.generate(28, (index) {
            double angle = index * math.pi / 14;
            double x = 190 + 150 * math.cos(angle);
            double y = 300 + 150 * math.sin(angle);
            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: x,
                  top: y,
                  child: CustomPaint(
                    size: const Size(30, 45),
                    painter: (index == 2 ||
                            index == 3 ||
                            index == 11 ||
                            index == 12 ||
                            index == 17 ||
                            index == 28 ||
                            index == 25)
                        ? TrapezoidCurvePainter(
                            // 빈 구역
                            color: Colors.white,
                            topStartX: 0,
                            topEndX: 80,
                            topStartY: 40,
                            topEndY: 50,
                            bottomStartX: 0,
                            bottomEndX: 80,
                            bottomStartY: 10,
                            bottomEndY: 0,
                            curveIntensity: 0,
                            rotationAngle: angle * 180 / math.pi,
                          )
                        : TrapezoidCurvePainter(
                            color: oneFloor,
                            topStartX: 0,
                            topEndX: 80,
                            topStartY: 39,
                            topEndY: 48,
                            bottomStartX: 0,
                            bottomEndX: 80,
                            bottomStartY: 11,
                            bottomEndY: 2,
                            curveIntensity: 40,
                            rotationAngle: angle * 180 / math.pi,
                          ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
