import 'package:material_app/Styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';

import '../Styles/colors.dart';



app_bar ({
  bool ? autolead,
  Widget ? actions,
  String? title
}){
  return AppBar(

    title: Text(title.toString(),style: txt_w500_mont(),),
    centerTitle: true,

    automaticallyImplyLeading:autolead?? false,
    backgroundColor: Colors.white,
    actions: [
      actions??Container()
    ],
    iconTheme: const IconThemeData(color: black),
    elevation: 0,
  );
}