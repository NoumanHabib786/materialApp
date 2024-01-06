import 'package:flutter_animate/flutter_animate.dart';
import 'package:material_app/Styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';

import '../Styles/colors.dart';

app_bar({bool? autolead, Widget? actions, String? title}) {
  return AppBar(
    title: Text(
      title.toString(),
      style: txt_w500_mont(),
    )
        .animate(
            // delay: 100.ms,
            )
        .fadeIn(delay: 200.ms)
        .shimmer(duration: 200.ms),
    centerTitle: true,
    automaticallyImplyLeading: autolead ?? false,
    backgroundColor: Colors.white,
    actions: [actions ?? Container()],
    iconTheme: const IconThemeData(color: mainBlack),
    elevation: 0,
  );
}
