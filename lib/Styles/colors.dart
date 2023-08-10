import 'package:flutter/material.dart';
const MaterialColor black = MaterialColor(_blackPrimaryValue, <int, Color>{
  50: Color(0xFFE0E0E0),
  100: Color(0xFFB3B3B3),
  200: Color(0xFF808080),
  300: Color(0xFF4D4D4D),
  400: Color(0xFF262626),
  500: Color(_blackPrimaryValue),
  600: Color(0xFF000000),
  700: Color(0xFF000000),
  800: Color(0xFF000000),
  900: Color(0xFF000000),
});
 const int _blackPrimaryValue = 0xFF000000;

 const MaterialColor blackAccent = MaterialColor(_blackAccentValue, <int, Color>{
  100: Color(0xFFA6A6A6),
  200: Color(_blackAccentValue),
  400: Color(0xFF737373),
  700: Color(0xFF666666),
});
 const int _blackAccentValue = 0xFF8C8C8C;