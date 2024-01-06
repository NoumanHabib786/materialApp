import 'dart:async';

import 'package:material_app/Providers/auth_Provider.dart';
import 'package:material_app/Screens/UserScreens/home.dart';
import 'package:material_app/Screens/UserScreens/sign_in.dart';
import 'package:material_app/Styles/colors.dart';
import 'package:material_app/Styles/text_styles.dart';
import 'package:material_app/Widgets/navigators.dart';
import 'package:material_app/Widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Providers/functions.dart';
import '../../Widgets/button.dart';
import '../../Widgets/images.dart';
import '../../Widgets/sized_box.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController controller = TextEditingController();
  TextEditingController email_cont = TextEditingController();
  TextEditingController password_cont = TextEditingController();

  bool obs = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  var key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auths, child) {
        return ModalProgressHUD(
          inAsyncCall: auths.googleloading,
          progressIndicator: loading,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    floating: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.elliptical(150, 100))),
                    expandedHeight: 5.h,
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                          color: mainBlack,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.elliptical(150, 100))),
                    ),
                  )
                ];
              },
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(2.0.h),
                  child: Form(
                    key: key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        height(3),
                        Text(
                          "Create Account",
                          style: txt_w600_mont(fontSize: 20.sp),
                        ),
                        height(5),
                        Text(
                          "Fill Your Details Or Continue With Social Media",
                          style: txt_w500_nuito(
                              fontSize: 12.sp, color: Colors.grey.shade500),
                        ),
                        height(5),
                        text_field(
                          context: context,
                          controller: email_cont,
                          onTap: () {},
                          obs: false,
                          hint_text: "Please enter email",
                          icon: Image.asset(
                            "assets/icons/Email.png",
                            cacheHeight: 30,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        height(5),
                        text_field_password(
                            onTap: () {
                              setState(() {
                                obs = !obs;
                              });
                            },
                            context: context,
                            controller: password_cont,
                            obs: obs,
                            hint_text: "Please enter password"),
                        height(5),
                        black_button(
                            load: auths.signUpLoad,
                            function: () {
                              if (key.currentState!.validate()) {
                                auths.signUp(
                                    context: context,
                                    email: email_cont,
                                    pass: password_cont);
                              }
                            },
                            btn_name: "Sign Up"),
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
                            width(2),
                            Text(
                              "Or Continue with",
                              style: txt_simple_mont(
                                  color: Colors.grey.shade500, fontSize: 12.sp),
                            ),
                            width(2),
                            const CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.grey,
                            ),
                          ],
                        ),
                        height(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                auths.signInWithGoogle();
                              },
                              child: Container(
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
                            ),
                            width(5),
                            Container(
                              decoration: BoxDecoration(
                                  // color: Colors.black,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.black,
                                  )),
                              padding: EdgeInsets.all(0.5.h),
                              child: Image.asset(
                                "assets/icons/facebook.png",
                                width: 9.w,
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
                              next_Screen: const SignInScreen(),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an Account ? ",
                                style: txt_simple_mont(fontSize: 11.sp),
                              ),
                              Text(
                                "Sign In",
                                style:
                                    txt_w500_mont(fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
