import 'package:allcon/Pages/Seat/SeatLayout/CustomFigure/TrapezoidCurve.dart';
import 'package:allcon/Util/Theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/widgets.dart';

class OlympicChaejo extends StatelessWidget {
  const OlympicChaejo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Center(
            child: SizedBox(
              width: 700,
              height: 700,
              child: Stack(
                children: [
                  ...secondSeat(secondSeatCenter(context)),
                  ...firstSeat(firstSeatCenter(context)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> secondSeat(Offset center) {
    return List.generate(30, (index) {
      double angle = index * 2 * math.pi / 30;
      double x = center.dx + 250 * math.cos(angle) + 150;
      double y = center.dy + 250 * math.sin(angle);
      return Positioned(
        left: x,
        top: y,
        child: CustomPaint(
          size: const Size(30, 45),
          painter: TrapezoidCurvePainter(
            color: secondFloor,
            topStartX: 0,
            topEndX: 60,
            topStartY: 49,
            topEndY: 55,
            bottomStartX: 0,
            bottomEndX: 60,
            bottomStartY: 3,
            bottomEndY: -3,
            curveIntensity: 40,
            rotationAngle: angle * 180 / math.pi,
          ),
        ),
      );
    });
  }

  List<Widget> firstSeat(Offset center) {
    return List.generate(28, (index) {
      double angle = index * math.pi / 14;
      double x = center.dx + 150 * math.cos(angle) + 150;
      double y = center.dy + 150 * math.sin(angle);
      return Positioned(
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
      );
    });
  }

  // secondSeat의 중심 좌표를 계산하는 함수
  Offset secondSeatCenter(BuildContext context) {
    return Offset(MediaQuery.of(context).size.width / 2,
        MediaQuery.of(context).size.height / 2);
  }

  // firstSeat의 중심 좌표를 계산하는 함수
  Offset firstSeatCenter(BuildContext context) {
    return Offset(MediaQuery.of(context).size.width / 2,
        MediaQuery.of(context).size.height / 2);
  }
}
