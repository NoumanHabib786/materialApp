import 'package:material_app/Screens/UserScreens/home.dart';
import 'package:material_app/Screens/UserScreens/sign_in.dart';
import 'package:material_app/Screens/onboard.dart';
import 'package:material_app/Widgets/navigators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Functions_Provider with ChangeNotifier {
  bool load = false;

  onLoad(bool set_load) {
    load = set_load;
    notifyListeners();
  }


}
