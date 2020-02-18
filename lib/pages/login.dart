import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../sign_in.dart';
import '../colors.dart';
import 'content.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String anim = "Aparecer";

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            _background(),
            Positioned(
              top: appSize.height * 0.2,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  width: appSize.width,
                  height: appSize.width,
                  child: new FlareActor(
                    "assets/TL.flr",
                    animation: anim,
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    callback: (s) {
                      setState(() {
                        anim = "Continuo";
                      });
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: appSize.height * 0.12,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  _signInButton(),
                  Text(
                    "somente @thunderatz.org",
                    style: const TextStyle(
                      color: const Color(0xffa4a4a4),
                      fontWeight: FontWeight.w900,
                      fontFamily: "BrandonText",
                      fontStyle: FontStyle.normal,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _background() {
    // This widget acts purely as a container that controlls how the `_BackgroundCurvePainter` draws
    return WaveWidget(
      config: CustomConfig(
        colors: [
          Colors.white70,
          Colors.white54,
          Colors.white30,
          Colors.white24,
        ],
        durations: [32000, 21000, 18000, 5000],
        heightPercentages: [0.6, 0.61, 0.63, 0.65],
        blur: MaskFilter.blur(BlurStyle.solid, 0),
      ),
      backgroundColor: AppColors.AzulTR,
      waveAmplitude: 0,
      size: MediaQuery.of(context).size,
    );
  }

  Widget _signInButton() {
    return MaterialButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().then((v) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Content(),
            ),
          );
        }, onError: (err) {
          Fluttertoast.showToast(
            msg: "Falha no login!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      color: AppColors.AzulTR,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
