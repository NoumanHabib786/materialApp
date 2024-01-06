import 'package:another_flushbar/flushbar_route.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:material_app/Styles/colors.dart';
import 'package:material_app/Styles/text_styles.dart';
import 'package:sizer/sizer.dart';

class UtilsNotify {
  static void fieldFoucsChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
  //
  // static toastMessage(String message) {
  //   Fluttertoast.showToast(
  //     msg: message,
  //   );
  // }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        flushbarStyle: FlushbarStyle.FLOATING,
        messageText: Text(
          message,
          style: txt_simple_nunito(fontSize: 11.sp, color: Colors.white),
        ),
        borderRadius: BorderRadius.circular(12),
        padding: EdgeInsets.all(2.h),
        duration: const Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: mainBlack,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
      )..show(context),
    );
  }
}
