import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thunderlanchonete/colors.dart';
import 'package:thunderlanchonete/model/state.dart';
import 'package:thunderlanchonete/state_widget.dart';

class ProfileScreen extends StatelessWidget {
  StateModel appState;

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 10),
            child: Text(
              appState.user.uid,
              style: TextStyle(
                color: Colors.black12,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: _profileInfo(context),
          ),
          SizedBox(height: 30),
          _balance(),
          Text("${MediaQuery.of(context).size}"),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NAME',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        Text(
          appState.user.displayName,
          style: TextStyle(
            fontSize: 25,
            color: AppColors.AzulTR,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'EMAIL',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        Text(
          appState.user.email,
          style: TextStyle(
            fontSize: 25,
            color: AppColors.AzulTR,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _balance() {
    return Stack(
      children: [
        CurveTB(),
        Positioned(
          bottom: 20,
          right: 35,
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
              StreamBuilder(
                stream: Firestore.instance
                    .collection('users')
                    .document(appState.user.uid)
                    // .document(uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return new Text("L...");
                  }
                  var userDocument = snapshot.data;
                  return new Text(
                    NumberFormat("00").format(userDocument["tb"]),
                    style: TextStyle(
                      fontSize: 100,
                      color: Colors.white,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 35,
          left: 10,
          child: Text(
            "saldo",
            style: TextStyle(
              fontFamily: "BrandonText",
              fontSize: 32,
              color: AppColors.AzulTR,
            ),
          ),
        ),
      ],
    );
  }

  Widget _addBalanceButton() {
    return MaterialButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      color: Colors.green,
      child: Text(
        'Adicionar Saldo',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}

class CurveTB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140,
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

    Offset p1 = Offset(0, size.height * 0.7);
    Offset p2 = Offset(0, size.height);
    Offset p3 = Offset(size.width * 0.8, size.height);
    Offset p4 = Offset(size.width * 1.2, size.height * 0.3);
    Offset p5 = Offset(size.width, size.height * 0.3);
    Offset p6 = Offset(size.width, 0);
    Offset p7 = Offset(size.width * 0.8, 0);
    Offset p8 = Offset(size.width * 0.3, size.height * 0.7);

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
