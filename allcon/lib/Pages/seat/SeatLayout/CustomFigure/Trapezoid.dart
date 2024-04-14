import 'package:flutter/material.dart';

class TrapezoidPainter extends CustomPainter {
  final double moveToX;
  final double moveToY;
  final double lineToX1;
  final double lineToY1;
  final double lineToX2;
  final double lineToY2;
  final double lineToX3;
  final double lineToY3;
  double rotation;
  final Color color;

  TrapezoidPainter({
    this.moveToX = 0,
    this.moveToY = 0,
    this.lineToX1 = 1,
    this.lineToY1 = 1,
    this.lineToX2 = 1,
    this.lineToY2 = 1,
    this.lineToX3 = 0,
    this.lineToY3 = 1,
    this.rotation = 0,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color; // 사다리꼴 색상을 설정합니다.
    Path path = Path()
      ..moveTo(size.width * moveToX, size.height * moveToY) // 시작점을 설정합니다.
      ..lineTo(
          size.width * lineToX1, size.height * lineToY1) // 첫 번째 꼭지점으로 선을 그립니다.
      ..lineTo(
          size.width * lineToX2, size.height * lineToY2) // 두 번째 꼭지점으로 선을 그립니다.
      ..lineTo(
          size.width * lineToX3, size.height * lineToY3) // 세 번째 꼭지점으로 선을 그립니다.
      ..close(); // 사다리꼴을 완성합니다.

    // 회전 변환 행렬을 생성합니다.
    final transform = Matrix4.rotationZ(rotation);

    // 캔버스에 회전 변환을 적용하여 사다리꼴을 그립니다.
    canvas.drawPath(path.transform(transform.storage), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // shouldRepaint를 false로 설정하여 repaint 방지
  }
}
