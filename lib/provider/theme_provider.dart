import 'package:flutter/material.dart';
import 'package:pmsna1/settings/styles_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeData? _theme;
  ThemeProvider(BuildContext context, int idtema){
    setthemeData(idtema, context);
  }

  getthemeDatas() => this._theme;
  //setthemeDatas(ThemeData theme ){
    //this._theme = theme;
    //notifyListeners();
  //} 

  setthemeData(int? index, BuildContext context) async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if (index == 1) {
    _theme = StylesSettings.darkTheme(context);
    sharedPreferences.setInt('id_tema', 1);
    await sharedPreferences.setBool('is_dark', true);
  } else if (index == 2) {
    _theme=StylesSettings.customtheme(context);
    sharedPreferences.setInt('id_tema', 2);
  } else {
    _theme=StylesSettings.lightTheme(context);
    sharedPreferences.setInt('id_tema', 0);
    await sharedPreferences.setBool('is_dark', false);
  }
  notifyListeners();
}

}