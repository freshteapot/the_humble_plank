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
      accentColor: Colors.cyan[300],
      buttonColor: Colors.grey[800],
      textSelectionColor: Colors.cyan[100],
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
      ),
    );
  }
}
