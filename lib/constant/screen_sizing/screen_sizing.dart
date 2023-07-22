import 'package:flutter/material.dart';

class MyScreenSizing {
  static EdgeInsets screenPadding({
    double L = 15,
    double T = 25,
    double R = 15,
    double B = 5,
  }) =>
      EdgeInsets.fromLTRB(L, T, R, B);

  static EdgeInsets bottomNavPadding({
    double L = 10,
    double T = 15,
    double R = 10,
    double B = 10,
  }) =>
      EdgeInsets.fromLTRB(L, T, R, B);
}
