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
          Stack(
            children: <Widget>[
              CurvedShape(),
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
                child: Image(
                  width: 130,
                  image: AssetImage("assets/ThunderLanchonete.png"),
                ),
              ),
            ],
          ),
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
        ],
      ),
    );
  }
}

class CurvedShape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: CURVE_HEIGHT,
      child: CustomPaint(
        painter: _MyPainter(),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
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
