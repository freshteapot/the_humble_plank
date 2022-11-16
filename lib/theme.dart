import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    final themeData = ThemeData.light();
    final textTheme = themeData.textTheme;
    final bodyText2 =
        textTheme.bodyText2.copyWith(decorationColor: Colors.transparent);

    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      primaryColor: Colors.grey[800],
      //textSelectionColor: Colors.cyan[100],
      toggleableActiveColor: Colors.cyan[300],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.cyan[300],
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: themeData.dialogBackgroundColor,
        contentTextStyle: bodyText2,
        actionTextColor: Colors.cyan[300],
      ),
      textTheme: textTheme.copyWith(
        bodyText2: bodyText2,
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.cyan[300]),
    );
  }
}

ButtonStyle primaryButtonStyle() {
  return ButtonStyle(
    padding: MaterialStateProperty.all(EdgeInsets.all(8)),
    backgroundColor: MaterialStateProperty.all(Color(0xfff4f4f4)),
    foregroundColor: MaterialStateProperty.all(Color(0xff333333)),
    shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    )),
    overlayColor: MaterialStateProperty.all(Color(0xfff4f4f4)),
    side: MaterialStateProperty.all<BorderSide>(
        BorderSide(color: Colors.black, width: 1)),
  );
}
