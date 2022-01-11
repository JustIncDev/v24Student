import 'package:flutter/material.dart';
import 'package:v24_student_app/res/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: const Center(
          child: Text(
            'Our future logo',
            style: TextStyle(fontSize: 15.0, color: AppColors.black),
          ),
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    var paint = Paint();
    var firstPath = Path();

    firstPath.moveTo(0, height * 0.2);

    firstPath.quadraticBezierTo(width * 0.2, height * 0.22, width * 0.05, height * 0.15);

    firstPath.quadraticBezierTo(width * 0.18, height * 0.1, width * 0.195, height * 0.02);

    firstPath.close();

    paint.color = AppColors.lavenderBlue;
    canvas.drawPath(firstPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
