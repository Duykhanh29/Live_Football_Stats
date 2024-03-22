import 'package:flutter/material.dart';
import 'dart:math' as math;

class PitchPainter extends CustomPainter {
  double _degreeToRadians(num degree) {
    return (degree * math.pi) / 180.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paintOutline = Paint();
    paintOutline.color = Colors.green;
    paintOutline.style = PaintingStyle.fill;
    canvas.drawPaint(paintOutline);
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;

    // frame of pitch
    // Offset centerPitch = Offset(size.width / 2, size.width / 2);
    // double width = size.width * 0.94;
    // double height = size.height * 0.94;
    // Rect rect =
    //     Rect.fromCenter(center: centerPitch, width: width, height: height);
    // Vẽ 4 đường thẳng từng cạnh của hình chữ nhật
    Offset topLeftPoint = Offset(size.width * 0.03, size.height * 0.03);
    Offset topRightPoint = Offset(size.width * 0.97, size.height * 0.03);
    Offset bottomLeftPoint = Offset(size.width * 0.03, size.height * 0.97);
    Offset bottomRightPoint = Offset(size.width * 0.97, size.height * 0.97);
    canvas.drawLine(topLeftPoint, topRightPoint, paint); // Đường trên
    canvas.drawLine(topLeftPoint, bottomLeftPoint, paint); // Đường phải
    canvas.drawLine(topRightPoint, bottomRightPoint, paint); // Đường dưới
    canvas.drawLine(bottomLeftPoint, bottomRightPoint, paint); // Đường trái

    // cross line
    canvas.drawLine(Offset(size.width * 0.03, size.height * 0.5),
        Offset(size.width * 0.97, size.height * 0.5), paint);

    // center circle
    final paintCenterCircle = Paint()
      ..color = Colors.white // Màu sắc của đường viền
      ..style = PaintingStyle.stroke // Chỉ vẽ kẻ đường viền
      ..strokeWidth = 2.0;
    final center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, size.width * 0.14, paintCenterCircle);

    // another way to draw cỉrcle
    //  var path = Path();
    // path.addOval(Rect.fromCircle(
    //   center: Offset(size.width / 2, size.height / 2),
    //   radius: 100,
    // ));
    // canvas.drawPath(path, paint);

    // centre point
    final paintPoint = Paint()
      ..color = Colors.white // Màu sắc của điểm chấm
      ..style = PaintingStyle.fill // Vẽ phần bên trong của đường tròn
      ..strokeWidth =
          4.0; // Độ rộng của đường viền, được sử dụng để tạo điểm chấm

    // Vẽ một điểm chấm tại vị trí (size.width / 2, size.height / 2)
    final centerPointOffset = Offset(size.width / 2, size.height / 2);
    final radius = 5.0; // Bán kính của điểm chấm, được đặt nhỏ để tạo điểm chấm
    canvas.drawCircle(centerPointOffset, radius, paintPoint);

    // // corners
    // double radiusCorner = size.width * 0.06;

    // var cornerBottomLeft = Rect.fromCircle(
    //     center: Offset(size.width * 0.03, size.height * 0.97),
    //     radius: size.width * 0.08);

    //
    Paint paintGoal = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    Rect homeGoal = Rect.fromPoints(
        Offset(size.width / 2 - size.width * 0.08, size.height * 0.97),
        Offset(size.width / 2 + size.width * 0.08, size.height * 0.99));
    Rect awayGoal = Rect.fromPoints(
        Offset(size.width / 2 - size.width * 0.08, size.height * 0.01),
        Offset(size.width / 2 + size.width * 0.08, size.height * 0.03));
    canvas.drawRect(homeGoal, paintGoal);
    canvas.drawRect(awayGoal, paintGoal);

    // round 1
    Rect homeGoal1 = Rect.fromPoints(
        Offset(size.width / 2 - size.width * 0.14, size.height * 0.91),
        Offset(size.width / 2 + size.width * 0.14, size.height * 0.97));
    Rect awayGoal1 = Rect.fromPoints(
        Offset(size.width / 2 - size.width * 0.14, size.height * 0.03),
        Offset(size.width / 2 + size.width * 0.14, size.height * 0.09));
    canvas.drawRect(homeGoal1, paintGoal);
    canvas.drawRect(homeGoal1, paintGoal);

    // pen points
    double penRadius = 3;
    final pen1Point = Offset(size.width / 2, size.height * 0.85);
    final pen2Point = Offset(size.width / 2, size.height * 0.15);
    canvas.drawCircle(pen1Point, penRadius, paintPoint);
    canvas.drawCircle(pen2Point, penRadius, paintPoint);

    // 16m50 area
    Rect safeArea1 = Rect.fromPoints(
        Offset(size.width / 2 - size.width * 0.26, size.height * 0.79),
        Offset(size.width / 2 + size.width * 0.26, size.height * 0.97));
    Rect safeArea2 = Rect.fromPoints(
        Offset(size.width / 2 - size.width * 0.26, size.height * 0.03),
        Offset(size.width / 2 + size.width * 0.26, size.height * 0.21));
    canvas.drawRect(safeArea1, paintGoal);
    canvas.drawRect(safeArea2, paintGoal);

    // circle 2

    Rect homeCircle1Rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height * 0.85),
        radius: size.height * 0.1);
    Rect homeCircle2Rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height * 0.15),
        radius: size.height * 0.1);
    double startAngle2 = _degreeToRadians(37);
    double sweepAngle2 = _degreeToRadians(107);
    double startAngle1 = _degreeToRadians(-37);
    double sweepAngle1 = _degreeToRadians(-107);
    const useCenter = false;

    canvas.drawArc(homeCircle1Rect, startAngle1, sweepAngle1, useCenter,
        paintCenterCircle);
    canvas.drawArc(homeCircle2Rect, startAngle2, sweepAngle2, useCenter,
        paintCenterCircle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
