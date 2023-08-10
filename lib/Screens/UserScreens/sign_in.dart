import 'dart:async';

import 'package:material_app/Screens/UserScreens/sign_up.dart';
import 'package:material_app/Styles/text_styles.dart';
import 'package:material_app/Widgets/app_bar.dart';
import 'package:material_app/Widgets/button.dart';
import 'package:material_app/Widgets/sized_box.dart';
import 'package:material_app/Widgets/snack_ar.dart';
import 'package:material_app/Widgets/text_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Providers/functions.dart';
import '../../Styles/colors.dart';
import '../../Widgets/images.dart';
import '../../Widgets/navigators.dart';
import '../../main.dart';
import 'home.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController email_Controller = TextEditingController();
  TextEditingController pass_controller = TextEditingController();
  bool obs = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  GlobalKey key = GlobalKey<FormState>();

  void signIn() async {
    try {
      await auth
          .signInWithEmailAndPassword(
        email: email_Controller.text.trimLeft(),
        password: pass_controller.text,
      )
          .then((value) {
        navigate_remove_untill(
          context: context,
          next_Screen: HomeScreen(name: value.user!.email),
        );
      });

      // If the authentication is successful, navigate to the HomeScreen

    } catch (e) {
      // Handle specific Firebase exceptions and show custom error messages
      if (e is FirebaseAuthException) {
        // Show user-friendly error message based on the error code
        String errorMessage = '';
        switch (e.code) {
          case 'user-not-found':
            errorMessage =
                'User not found. Please check your email or sign up.';
            break;
          case 'wrong-password':
            errorMessage = 'Invalid password. Please try again.';
            break;
          // Add more cases as needed for different error types
          default:
            errorMessage = 'An error occurred. Please try again later.';
        }
        // Show the error message to the user (e.g., using a dialog or a SnackBar)
        snack_message(text: errorMessage, context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              height(18),
              Text(
                "Welcome back to ",
                style: txt_w500_mont(fontSize: 16.sp),
              ),
              Text(
                "Construction Material App",
                style: txt_w600_mont(fontSize: 18.sp),
              ),
              height(2),
              Text(
                "Sign in to access your construction projects",
                style: txt_w500_nuito(
                    fontSize: 12.sp, color: Colors.grey.shade500),
              ),
              SizedBox(
                height: 5.h,
              ),
              Form(
                key: key,
                child: Column(
                  children: [
                    text_field(
                        onTap: () {},
                        obs: false,
                        context: context,
                        icon: Image.asset(
                          "assets/icons/Person.png",
                          cacheHeight: 30,
                          color: Colors.grey.shade500,
                        ),
                        controller: email_Controller,
                        hint_text: "User Name"),
                    height(3),
                    text_field(
                        onTap: () {
                          setState(() {
                            obs = !obs;
                          });
                        },
                        context: context,
                        controller: pass_controller,
                        hint_text: "Password",
                        obs: obs),
                  ],
                ),
              ),
              height(3),
              Consumer<Functions_Provider>(
                builder: (context, value, child) {
                  return black_button(
                      value: value,
                      function: () => signIn(),
                      btn_name: "Sign In");
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 3,
                    backgroundColor: Colors.grey,
                  ),
                  width(1),
                  Text(
                    "Or Continue with",
                    style: txt_simple_mont(
                        color: Colors.grey.shade500, fontSize: 12.sp),
                  ),
                  width(1),
                  const CircleAvatar(
                    radius: 3,
                    backgroundColor: Colors.grey,
                  ),
                ],
              ),
              height(2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                        )),
                    padding: EdgeInsets.all(0.5.h),
                    child: Image.asset(
                      "assets/icons/Google.png",
                      width: 9.w,
                      // height: 3.h,
                    ),
                  ),
                  width(3),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                        )),
                    padding: EdgeInsets.all(0.5.h),
                    child: Image.asset(
                      "assets/icons/facebook.png",
                      width: 9.w,
                      color: Colors.white,
                      // height: 3.h,
                    ),
                  ),
                  width(3),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                        )),
                    padding: EdgeInsets.all(0.5.h),
                    child: Image.asset(
                      "assets/icons/Apple Logo.png",
                      width: 9.w,
                      color: Colors.white,
                      // height: 3.h,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6.h,
              ),
              InkWell(
                onTap: () {
                  navigate_push(
                    context: context,
                    next_Screen: SignUpScreen(),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account ? ",
                      style: txt_simple_mont(fontSize: 11.sp),
                    ),
                    Text(
                      "Sign Up",
                      style: txt_w500_mont(fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
