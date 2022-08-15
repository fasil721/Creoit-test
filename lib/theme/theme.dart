import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: NewTheme.primaryColor.withOpacity(0.7),
  primaryColor: NewTheme.secondaryColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(NewTheme.secondaryColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
  ),
);

class NewTheme {
  static const formFieldColor = Color(0xff333333);
  static const primaryColor = Color(0xff131313);
  static const secondaryColor = Color(0xffffffff);
  static const textColor = Color(0xffa8a8a8);
  static const shadeColor = Color(0xffFFE9E9);
}
