import 'package:demo_new/constant/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final myLightThemeData = ThemeData(
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
    ),
  ),
  canvasColor: Colors.transparent,
  fontFamily: 'robotoRegular',
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: MyColors.secondaryColor,
  ),
  cupertinoOverrideTheme: const CupertinoThemeData(
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(fontSize: 18,color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: MyColors.primaryColor
    )
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      textStyle: const TextStyle(
          letterSpacing: 1
      ),
      side: const BorderSide(color: MyColors.primaryColor, width: 2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
    ),
  ),
  colorScheme:
  ColorScheme.fromSwatch().copyWith(secondary: MyColors.primaryColor),
);