import 'package:fazwalls/theme/widget_themes/appbar_theme.dart';

import 'package:fazwalls/theme/widget_themes/checkbox_theme.dart';

import 'package:fazwalls/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';




class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: Colors.grey,
    brightness: Brightness.light,
    primaryColor: Colors.yellow,
    textTheme: TTextTheme.lightTextTheme,
   
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    
   
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: Colors.grey,
    brightness: Brightness.dark,
    primaryColor: Colors.yellow,
    textTheme: TTextTheme.darkTextTheme,
  
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    
  
  );
}
