import 'package:flutter/material.dart';

import 'app_colors.dart';


class MyThemes {
  //DARCK THEME
  static final darkTheme = ThemeData(
      buttonTheme: const ButtonThemeData(buttonColor: primaryColor),
      // scaffoldBackgroundColor: secondaryColor,
      primaryColor: primaryColor,
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(primaryColor))),
      iconTheme: const IconThemeData(color: primaryColor, opacity: 0.8),

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primaryColor,
        selectionColor: primaryColor,
      ),
      colorScheme: const ColorScheme.dark().copyWith(secondary: secondaryColor),
      useMaterial3: false);

  // light theme
  static final lightTheme = ThemeData(
    primaryColorLight: primaryColor,
    buttonTheme: const ButtonThemeData(
      buttonColor: primaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
    )),
    dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(25.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(25.0),
      ),
      fillColor: inputFillColor,
    )),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      side: const BorderSide(width: 1.0, color: primaryColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
    )),
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    // appBarTheme: AppBarTheme(
    //     backgroundColor: AppColors.scaffoldBackground,
    //     iconTheme: const IconThemeData(color: Colors.black),
    //     elevation: 0.0),
    checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    )),

    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(primaryColor))),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionColor: primaryColor,
    ),

    primaryColor: primaryColor,
    iconTheme: const IconThemeData(color: primaryColor, opacity: 0.8),

    colorScheme: const ColorScheme.light().copyWith(
      secondary: secondaryColor,
    ),
    useMaterial3: false
  );
}
