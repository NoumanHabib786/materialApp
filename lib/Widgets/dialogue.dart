import 'package:material_app/Styles/text_styles.dart';
import 'package:material_app/Widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool?> closeDialogue(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          "Do you want to Close ?",
          style: txt_w500_nuito(),
        ),
        actions: [
          button_outline(() => Navigator.pop(context,false), 'No'),
          button_fill(context,"Yes",()=>Navigator.pop(context, true)),
        ],
      );
    },
  );
}

