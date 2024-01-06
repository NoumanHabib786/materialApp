import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_app/Providers/functions.dart';
import 'package:material_app/Screens/UserScreens/home.dart';
import 'package:material_app/Screens/onboard.dart';
import 'package:material_app/Widgets/navigators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'ServicerScreen/mainServicerScreen.dart';
import 'UserScreens/sign_in.dart';
import 'adminScreens/mainScreen.dart';
import '../Widgets/firebase_variables.dart';

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
  CollectionReference users = FirebaseFirestore.instance.collection('user');

  void isLogin(BuildContext context) {
    Timer(const Duration(seconds: 6), () {
      if (auth.currentUser != null) {
        print(auth.currentUser);
        users
            .where('id', isEqualTo: auth.currentUser!.uid)
            .get()
            .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            Map<String, dynamic> userData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
            print(userData['role']);
            if (userData['role'] == "admin") {
              navigate_remove_untill(
                  context: context, next_Screen: const MainAdminScreen());
            }else if (userData['role'] == "Service") {
              navigate_remove_untill(
                  context: context, next_Screen: const MainServicerScreen());
            } else {
              navigate_remove_untill(
                  context: context,
                  next_Screen: HomeScreen(
                    name: userData['name'],
                  ));
            }
          } else {
            navigate_remove_untill(context: context, next_Screen: SignInScreen());
            print('User document not found');
          }
        });
      } else {
        navigate_replace(context: context, next_Screen: const OnBordingScreen());
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
