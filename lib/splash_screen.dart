import 'dart:async';

import 'package:material_app/Providers/functions.dart';
import 'package:material_app/Screens/UserScreens/home.dart';
import 'package:material_app/Screens/onboard.dart';
import 'package:material_app/Widgets/navigators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'Widgets/firebase_variables.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        height = 40.0.h;
        width = 80.0.w;
      });
    });
    isLogin(context);
  }

  void isLogin(BuildContext context) {
    Timer(const Duration(seconds: 6), () {
      if (auth.currentUser != null) {
        print(auth.currentUser);
        navigate_replace(context: context, next_Screen: HomeScreen());
      } else {
        navigate_replace(context: context, next_Screen: OnBordingScreen());
      }
    });
  }

  var height = 0.0;
  var width = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: AnimatedSize(
          duration: const Duration(seconds: 2),
          curve: Curves.easeOutSine,
          child: SizedBox(
            height: height,
            width: width,
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.cover,
            ),
          )),
    ));
  }
}
