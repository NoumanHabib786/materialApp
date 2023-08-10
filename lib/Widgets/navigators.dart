import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

navigate_push({required BuildContext context, required Widget next_Screen}) {
  return Navigator.push(
      context,
      PageTransition(
          child: next_Screen,
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500)));
}

navigate_replace({required BuildContext context, required Widget next_Screen}) {
  return Navigator.pushReplacement(
      context,
      PageTransition(
          child: next_Screen,
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500)));
}

navigate_remove_untill(
    {required BuildContext context, required Widget next_Screen}) {
  return Navigator.pushAndRemoveUntil(
    context,
    PageTransition(
        child: next_Screen,
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 500)),
    (route) => false,
  );
}

