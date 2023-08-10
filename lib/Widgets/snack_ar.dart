import 'package:flutter/material.dart';

snack_message({required String text,required BuildContext context}) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(text)));
}
