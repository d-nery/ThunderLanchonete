import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thunderlanchonete/colors.dart';

import '../../sign_in.dart';

const CURVE_HEIGHT = 180.0;
const AVATAR_RADIUS = CURVE_HEIGHT * 0.4;
const AVATAR_DIAMETER = AVATAR_RADIUS * 2;

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          topBar(),
          Container(
            child: Text(
              uid,
              style: TextStyle(
                color: Colors.black12,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NAME',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 25,
                          color: AppColors.AzulTR,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'EMAIL',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    Text(
                      email,
                      style: TextStyle(
                          fontSize: 25,
                          color: AppColors.AzulTR,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 50),
          Column(
            children: [
              Text(
                "saldo",
                style: TextStyle(
                  fontFamily: "BrandonText",
                  fontSize: 32,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(10)),
                  color: AppColors.AzulTR,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: SvgPicture.asset(
                        "assets/TB.svg",
                        color: Colors.white,
                        height: 25,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "84",
                      style: TextStyle(
                        fontSize: 100,
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // CurveTB(),
        ],
      ),
    );
  }
}

final topBar = () => Stack(
      children: <Widget>[
        CurveTop(),
        Positioned(
          right: 20,
          bottom: 0,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 62,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                imageUrl,
              ),
              radius: 56,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 5,
          child: Container(
            width: 130,
            height: 130,
            child: new FlareActor(
              "assets/TL.flr",
              animation: "Continuo",
              alignment: Alignment.center,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );

class CurveTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: CURVE_HEIGHT,
      child: CustomPaint(
        painter: _TopPainter(),
      ),
    );
  }
}

class _TopPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = AppColors.AzulTR;

    Offset topLeft = Offset(0, 0);
    Offset bottomLeft = Offset(0, size.height);
    Offset topRight = Offset(size.width, 0);
    Offset bottomRight = Offset(size.width, size.height * 0.5);

    Path path = Path()
      ..moveTo(topLeft.dx, topLeft.dy)
      ..lineTo(bottomLeft.dx, bottomLeft.dy)
      ..cubicTo(size.width * 0.4, size.height, size.width * 0.6,
          size.height * 0.4, bottomRight.dx, bottomRight.dy)
      ..lineTo(topRight.dx, topRight.dy)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CurveTB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: CURVE_HEIGHT,
      child: CustomPaint(
        painter: _TBPainter(),
      ),
    );
  }
}

class _TBPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = AppColors.AzulTR;

    Offset p1 = Offset(0, size.height * 0.85);
    Offset p2 = Offset(0, size.height);
    Offset p3 = Offset(size.width * 0.6, size.height);
    Offset p4 = Offset(size.width * 0.98, size.height * 0.15);
    Offset p5 = Offset(size.width, size.height * 0.15);
    Offset p6 = Offset(size.width, 0);
    Offset p7 = Offset(size.width * 0.4, 0);
    Offset p8 = Offset(size.width * 0.1, size.height * 0.85);

    Path path = Path()
      ..moveTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..lineTo(p3.dx, p3.dy)
      ..cubicTo(
          (p4.dx + p3.dx) / 2, p3.dy, (p4.dx + p3.dx) / 2, p4.dy, p4.dx, p4.dy)
      ..lineTo(p5.dx, p5.dy)
      ..lineTo(p6.dx, p6.dy)
      ..lineTo(p7.dx, p7.dy)
      ..cubicTo(
          (p7.dx + p8.dx) / 2, p7.dy, (p7.dx + p8.dx) / 2, p8.dy, p8.dx, p8.dy)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
