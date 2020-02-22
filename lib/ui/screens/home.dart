import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:thunderlanchonete/colors.dart';
import 'package:thunderlanchonete/model/state.dart';
import 'package:thunderlanchonete/state_widget.dart';

import 'package:thunderlanchonete/ui/screens/content/profile.dart';
import 'package:thunderlanchonete/ui/screens/content/store.dart';
import 'package:thunderlanchonete/ui/screens/login.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StateModel appState;
  Widget _child;
  GlobalKey<_TopBarState> topBarKey = new GlobalKey<_TopBarState>();

  @override
  void initState() {
    _child = ProfileScreen();
    super.initState();
  }

  Widget _buildContent() {
    if (appState.isLoading) {
      return Center(child: new CircularProgressIndicator());
    } else if (!appState.isLoading && appState.user == null) {
      return new LoginScreen();
    } else {
      return _buildTabView();
    }
  }

  Widget _buildTabView() {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Column(
        children: [
          TopBar(key: topBarKey),
          _child,
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: AppColors.AzulTR,
        items: <Widget>[
          Icon(Icons.account_circle, size: 30, color: Colors.white),
          Icon(Icons.shopping_basket, size: 30, color: Colors.white),
        ],
        height: 50,
        onTap: (index) {
          setState(() {
            switch (index) {
              case 0:
                _child = ProfileScreen();
                topBarKey.currentState.teste = true;
                break;
              case 1:
                _child = StoreScreen();
                topBarKey.currentState.teste = false;
                break;
            }

            // _child = AnimatedSwitcher(
            //   switchInCurve: Curves.easeOut,
            //   switchOutCurve: Curves.easeIn,
            //   duration: Duration(milliseconds: 500),
            //   child: _child,
            // );
          });
        },
      ),
    );
  }

  @override
  Widget build(context) {
    appState = StateWidget.of(context).state;
    return _buildContent();
  }
}

class TopBar extends StatefulWidget {
  TopBar({Key key}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> with SingleTickerProviderStateMixin {
  double barHeight = 450.0;
  double avatarRadius = 72.0;
  double logoSize = 330.0;
  bool teste = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: teste ? barHeight : 100,
      duration: Duration(milliseconds: 400),
      child: Stack(
        children: <Widget>[
          CurveTop(),
          Positioned(
            right: 20,
            bottom: 0,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 400),
              opacity: teste ? 1 : 0,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: avatarRadius + 8,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    StateWidget.of(context).state.user.photoUrl,
                  ),
                  radius: avatarRadius,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 5,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              width: teste ? logoSize : 50,
              height: teste ? logoSize : 50,
              child: new FlareActor(
                "assets/TL.flr",
                animation: "Continuo",
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: 30,
            right: -20,
            child: _signOutButton(context),
          ),
        ],
      ),
    );
  }

  Widget _signOutButton(BuildContext c) {
    return MaterialButton(
      onPressed: () async {
        StateWidget.of(context).signOut();
        // Navigator.of(c).pushReplacementNamed("/login");
      },
      shape: const CircleBorder(),
      color: Colors.red,
      height: 10,
    );
  }
}

class CurveTop extends StatefulWidget {
  @override
  _CurveTopState createState() => _CurveTopState();
}

class _CurveTopState extends State<CurveTop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        painter: _TopPainter(),
      ),
    );
  }
}

class _TopPainter extends CustomPainter {
  Paint curvePaint = new Paint()
    ..style = PaintingStyle.fill
    ..isAntiAlias = true
    ..color = AppColors.AzulTR;

  @override
  void paint(Canvas canvas, Size size) {
    Offset topLeft = Offset(0, 0);
    Offset bottomLeft = Offset(0, size.height * 0.9);
    Offset topRight = Offset(size.width, 0);
    Offset bottomRight = Offset(size.width, size.height * 0.6);

    Path path = Path()
      ..moveTo(topLeft.dx, topLeft.dy)
      ..lineTo(bottomLeft.dx, bottomLeft.dy)
      ..quadraticBezierTo(
          size.width * 0.4, size.height * 1.2, bottomRight.dx, bottomRight.dy)
      ..lineTo(topRight.dx, topRight.dy)
      ..close();

    canvas.drawPath(path, curvePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
