import 'package:flutter/material.dart';
import 'package:pmsna1/screens/add_post_screen.dart';
import 'package:pmsna1/screens/calendar_screen.dart';
import 'package:pmsna1/screens/dashboard_screen.dart';
import 'package:pmsna1/screens/list_favourites.dart';
import 'package:pmsna1/screens/list_popular_videos.dart';
import 'package:pmsna1/screens/login_screen.dart';
import 'package:pmsna1/screens/maps_screeen.dart';
import 'package:pmsna1/screens/register_screen.dart';
import 'package:pmsna1/screens/Onbearding_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    '/register': (BuildContext context) =>  const Registerscreen(),
    '/dash' :(BuildContext context) =>  DashboardScreen(),
    '/Onb' :(BuildContext context) =>  const MyApp(),
    '/add' :(BuildContext context) =>  AddPostScreen(),
    '/Calendar' :(BuildContext context) =>  TwoViewsButton(),
    '/popular' :(BuildContext context) =>  const ListPopularVideos(),
    '/login' :(BuildContext context) =>  const LoginScreen(),
    '/Favorites' :(BuildContext context) =>  const ListFvouritesCloud(),
    '/map' :(BuildContext context) => const MapSample()
  };
}