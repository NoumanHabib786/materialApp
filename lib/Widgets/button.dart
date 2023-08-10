import 'dart:async';

import 'package:material_app/Styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Styles/text_styles.dart';
import 'images.dart';

SizedBox black_button({var value, Function? function  , String? btn_name}) {
  return SizedBox(
    width: 100.w,
    height: 50,
    child: value.load
        ? loading
        : ElevatedButton(
        onPressed: () {
          value.onLoad(true);
          Timer(const Duration(seconds: 2), () {
            function!();
            value.onLoad(false);
          });
        },
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13))),
        child: Text(
          btn_name!,
          style: txt_w500_nuito(color: Colors.white),
        )),
  );
}

ElevatedButton button_outline(Function() function , String btn_name) {
  return ElevatedButton(
      onPressed: () {
        function();
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
              side:  const BorderSide(width: 1, color: black),
              borderRadius: BorderRadius.circular(20))),
      child: Text(
        btn_name,
        style: txt_simple_nunito(fontSize: 11.sp),
      ));
}
ElevatedButton button_fill(BuildContext context , String btn_name , Function function) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
      ),
      onPressed: () {
        function();
      },
      child: Text(btn_name,style: txt_simple_nunito(color: Colors.white),));
}

