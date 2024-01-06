import 'package:flutter/services.dart';
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
    TextInputType? keyBoardType,
    Widget? icon,
    int? lines,
    required BuildContext context,
    required TextEditingController controller}) {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please enter something";
      }
      return null;
    },
    keyboardType: keyBoardType ?? TextInputType.emailAddress,
    controller: controller,
    maxLines: lines ?? 1,
    obscureText: obs ?? false,
    style: txt_simple_nunito(fontSize: 13.sp),
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.com]'))
    ],
    decoration: InputDecoration(
        floatingLabelAlignment: FloatingLabelAlignment.start,
        alignLabelWithHint: true,
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.black , width: 1)),
        suffixIcon: IconButton(
          onPressed: () => onTap(),
          icon: icon ??
              Icon(
                obs == true
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey.shade500,
              ),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red , width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.black , width: 1)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.black , width: 1)),
        errorStyle: txt_simple_nunito(color: Colors.red, fontSize: 9.sp),
        labelText: hint_text!,
        labelStyle:
            txt_simple_nunito(color: Colors.grey.shade500, fontSize: 11.sp)),
  );
}


text_field_password(
    {bool? obs,
    required Function() onTap,
    String? hint_text,
    required BuildContext context,
    required TextEditingController controller}) {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please enter something";
      }
      else if (value.length<6)
        {
          return 'Please enter minimum 6 characters';
        }
      return null;
    },
    keyboardType: TextInputType.name,
    controller: controller,
    obscureText: obs ?? false,
    style: txt_simple_nunito(fontSize: 13.sp),

    decoration: InputDecoration(
        floatingLabelAlignment: FloatingLabelAlignment.start,
        alignLabelWithHint: true,
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.black , width: 1)),
        suffixIcon: IconButton(
          onPressed: () => onTap(),
          icon:
              Icon(
                obs == true
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey.shade500,
              ),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red , width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.black , width: 1)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.black , width: 1)),
        errorStyle: txt_simple_nunito(color: Colors.red, fontSize: 9.sp),
        labelText: hint_text!,
        labelStyle:
            txt_simple_nunito(color: Colors.grey.shade500, fontSize: 11.sp)),
  );
}

text_field_Note(
    {String? hint_text,
    TextInputType? keyBoardType,
    int? lines,
    required BuildContext context,
    required TextEditingController controller}) {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please enter something";
      }
      return null;
    },
    keyboardType: TextInputType.name,
    controller: controller,
    maxLines: lines ?? 1,
    style: txt_simple_nunito(fontSize: 13.sp),

    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        disabledBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1)),
        errorStyle: txt_simple_nunito(color: Colors.red, fontSize: 9.sp),
        labelText: hint_text!,
        labelStyle:
        txt_simple_nunito(color: Colors.grey.shade500, fontSize: 11.sp)),
  );
}

text_field_contact_Number(
    {String? hint_text,
    required BuildContext context,
    required TextEditingController controller}) {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please enter something";
      }

      return null;
    },
    maxLength: 10,
    keyboardType: TextInputType.number,
    controller: controller,
    style: txt_simple_nunito(fontSize: 13.sp),
    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[1-9]'))],
    decoration: InputDecoration(
        prefix: const Text("+92 "),
        filled: true,
        fillColor: Colors.grey.shade200,
        disabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        errorStyle: txt_simple_nunito(color: Colors.red, fontSize: 9.sp),
        labelText: hint_text!,
        labelStyle:
            txt_simple_nunito(color: Colors.grey.shade500, fontSize: 11.sp)),
  );
}

text_field_Number(
    {String? hint_text,
    int? length,
    required BuildContext context,
    required TextEditingController controller}) {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return hint_text;
      }

      return null;
    },
    maxLength: length ?? 2,
    keyboardType: TextInputType.number,
    controller: controller,
    style: txt_simple_nunito(fontSize: 13.sp),
    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        disabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1)),
        errorStyle: txt_simple_nunito(color: Colors.red, fontSize: 9.sp),
        labelText: hint_text!,
        labelStyle:
            txt_simple_nunito(color: Colors.grey.shade500, fontSize: 11.sp)),
  );
}
