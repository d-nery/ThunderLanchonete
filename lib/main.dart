import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thunderlanchonete/state_widget.dart';

import 'package:thunderlanchonete/ui/screens/home.dart';
import 'package:thunderlanchonete/ui/screens/login.dart';
import 'package:thunderlanchonete/ui/theme.dart';

void main() {
  runApp(new StateWidget(child: MyApp()));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      theme: buildTheme(),
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
