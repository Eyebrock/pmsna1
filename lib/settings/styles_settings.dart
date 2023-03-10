import 'package:flutter/material.dart';

class StylesSettings extends ChangeNotifier{


  static ThemeData lightTheme(BuildContext context){
    final theme = ThemeData.light();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(primary: Color.fromARGB(222, 202, 73, 116))
    );
  }

  static ThemeData darkTheme(BuildContext context){
    final theme = ThemeData.dark();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(primary: Color.fromARGB(222, 180, 1, 61))
    );
  }

  static ThemeData customtheme(BuildContext context){
    final theme = ThemeData.dark();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(primary: Color.fromARGB(222, 250, 165, 193),
      secondary:Color.fromARGB(199, 235, 16, 111))
    );
  }

  

}