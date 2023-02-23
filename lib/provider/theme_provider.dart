import 'package:flutter/material.dart';
import 'package:pmsna1/settings/styles_settings.dart';

class ThemeProvider with ChangeNotifier {

  ThemeData? _theme;
  ThemeProvider(BuildContext context){
    _theme = StylesSettings.lightTheme(context);
  }

  getthemeData() => this._theme;
  setthemeData(ThemeData theme ){
    this._theme = theme;
    notifyListeners();
  } 
}