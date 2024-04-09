import 'package:flutter/material.dart';
import 'dart:math' as math;

class TrapezoidCurvePainter extends CustomPainter {
  final Color color; // 변수로 받아올 색상
  final double topStartX, // 좌측상단 y좌표
      topEndX, // 좌측하단 y좌표
      topStartY, // 좌측상단 x좌표
      topEndY; // 좌측하단 x좌표
  final double bottomStartX, // 우측상단 y좌표
      bottomEndX, // 우측하단 y좌표
      bottomStartY, // 우측상단 x좌표
      bottomEndY; // 우측하단 x좌표
  final double curveIntensity; // 곡선의 정도를 나타내는 변수
  final double rotationAngle; // 회전 각도

  TrapezoidCurvePainter({
    required this.color,
    required this.topStartX,
    required this.topEndX,
    required this.topStartY,
    required this.topEndY,
    required this.bottomStartX,
    required this.bottomEndX,
    required this.bottomStartY,
    required this.bottomEndY,
    required this.curveIntensity,
    required this.rotationAngle,
  }); // 생성자 추가

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color // 변수로 받아온 색상 설정
      ..style = PaintingStyle.fill;

    Paint whitePaint = Paint() // 테두리 설정
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    Path path = Path();

    // 회전 변환 적용
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(rotationAngle * math.pi / 180);
    canvas.translate(-size.width / 2, -size.height / 2);

    // 시작점 설정
    path.moveTo(bottomStartX, bottomStartY);

    // 윗변 곡선
    path.quadraticBezierTo(
      (bottomEndX + topStartX) / curveIntensity, // 제어점 X 좌표
      (topStartY + bottomStartY) / 2, // 제어점 Y 좌표
      topStartX, // 끝점 X 좌표
      topStartY, // 끝점 Y 좌표
    );

    // 오른쪽 아래 대각선
    path.lineTo(topEndX, topEndY);

    // 아랫변 곡선
    path.quadraticBezierTo(
      (topEndX + bottomEndX) / 2, // 제어점 X 좌표
      (bottomEndY + topEndY) / curveIntensity, // 제어점 Y 좌표
      bottomEndX, // 끝점 X 좌표
      bottomEndY, // 끝점 Y 좌표
    );

    // 왼쪽 위 대각선
    path.lineTo(bottomStartX, bottomStartY);

    // 변을 하얀색으로 그리기
    canvas.drawPath(path, whitePaint);

    // 도형 채우기
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
