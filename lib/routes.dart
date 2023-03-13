import 'package:flutter/material.dart';
import 'package:pmsna1/screens/add_post_screen.dart';
import 'package:pmsna1/screens/dashboard_screen.dart';
import 'package:pmsna1/screens/register_screen.dart';
import 'package:pmsna1/screens/Onbearding_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    '/register': (BuildContext context) =>  const Registerscreen(),
    '/dash' :(BuildContext context) =>  DashboardScreen(),
    '/Onb' :(BuildContext context) =>  const MyApp(),
    '/add' :(BuildContext context) =>  AddPostScreen()
  };
}