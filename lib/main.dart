import 'package:flutter/material.dart';
import 'package:pmsna1/provider/flags_provider.dart';
import 'package:pmsna1/provider/theme_provider.dart';
import 'package:pmsna1/routes.dart';
import 'package:pmsna1/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final idtema= sharedPreferences.getInt('id_tema') ?? 0;
  runApp(MyApp(idtema: idtema));
}


class MyApp extends StatelessWidget {
  final int idtema;
  const MyApp({super.key,
  required this.idtema});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(context, idtema)),
        ChangeNotifierProvider(create: (_) => FlagosProvider())
      ],
      child: PMSNApp(),
    );
  }
}

class PMSNApp extends StatelessWidget {
  const PMSNApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: theme.getthemeDatas(),
      routes: getApplicationRoutes(),
      home: LoginScreen(),
    );
  }
}

