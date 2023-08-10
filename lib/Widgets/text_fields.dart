import 'package:material_app/Providers/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../Styles/text_styles.dart';

bool obs = false;

text_field(
    {bool? obs,
    required Function() onTap,
    String? hint_text,
    Widget? icon,
    required BuildContext context,
    required TextEditingController controller}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13), color: Colors.grey.shade300),
    padding: EdgeInsets.symmetric(horizontal: 2.h),
    child: TextFormField(
      validator: (value) {
        if(value==null && value!.isEmpty)
          {
            print("please enter something");
          }

      },
      controller: controller,
      obscureText: obs!,
      style: txt_simple_nunito(fontSize: 13.sp),
      decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () => onTap(),
            icon: icon ??
                Icon(
                  obs
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey.shade500,
                ),
          ),
          enabledBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: hint_text!,
          hintStyle:
              txt_simple_nunito(color: Colors.grey.shade500, fontSize: 11.sp)),
    ),
  );
}
