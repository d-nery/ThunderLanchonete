import 'package:flutter/material.dart';
import 'package:thunderlanchonete/colors.dart';

import './content/profile.dart';
import './content/store.dart';

class Content extends StatefulWidget {
  @override
  State createState() {
    return _ContentState();
  }
}

class _ContentState extends State {
  Widget _child;

  @override
  void initState() {
    _child = ProfileScreen();
    super.initState();
  }

  @override
  Widget build(context) {
    // Build a simple container that switches content based of off the selected navigation item
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: _child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.AzulTR,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.portrait,
              color: Colors.white,
            ),
            title: Text("Lala"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.present_to_all,
              color: Colors.white,
            ),
            title: Text("Lele"),
          ),
        ],
      ),
    );
  }

  // void _handleNavigationChange(int index) {
  //   setState(() {
  //     switch (index) {
  //       case 0:
  //         _child = HomeContent();
  //         break;
  //       case 1:
  //         _child = AccountContent();
  //         break;
  //       case 2:
  //         _child = GridContent();
  //         break;
  //     }
  //     _child = AnimatedSwitcher(
  //       switchInCurve: Curves.easeOut,
  //       switchOutCurve: Curves.easeIn,
  //       duration: Duration(milliseconds: 500),
  //       child: _child,);
  //   });
  // }
}
