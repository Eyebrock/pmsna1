import 'package:flutter/material.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:pmsna1/provider/theme_provider.dart';
import 'package:pmsna1/screens/list_post.dart';
import 'package:provider/provider.dart';
import 'package:pmsna1/settings/styles_settings.dart';

import '../firebase/facebook_autjentication.dart';
import '../firebase/google_authentication.dart';
import '../models/user_model.dart';


class DashboardScreen extends StatefulWidget {

  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkModeEnabled = false;
  GoogleAuth googleAuth= GoogleAuth();
  FaceAuth faceAuth= FaceAuth();
  UserModel? user;

  @override
  Widget build(BuildContext context) {
    if(ModalRoute.of(context)!.settings.arguments!=null){
      user = ModalRoute.of(context)!.settings.arguments as UserModel;
    }
    ThemeProvider theme= Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Social ITC SMOOCH'),
      ),
      body: ListPost(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.pushNamed(context, '/add').then((value){
            setState(() {
              
            });
          });
      }, label: const Text("Add Post"),
      icon: const Icon(Icons.add_comment),),
  
      
      drawer: Drawer(
        child: ListView(
          children: [
             UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(user!.photoUrl.toString()),
                ),
                accountName: Text(user!.name.toString()),
                accountEmail: Text(user!.email.toString())),
              ListTile(
                onTap: (){},
                title: Text('Practica 1'),
                subtitle: Text('Descripcion de la practica'),
                leading: Icon(Icons.settings),
                trailing: Icon(Icons.chevron_right),
              ),
              ListTile(
                onTap: () => Navigator.pushNamed(context, '/popular'),
                title: Text('API videos'),
                leading: Icon(Icons.movie),
                trailing: Icon(Icons.chevron_right),
              ),
              DayNightSwitcher(
                isDarkModeEnabled: isDarkModeEnabled,
                onStateChanged: (isDarkModeEnabled){
                  isDarkModeEnabled
                  ? theme.setthemeData(1,context)
                  : theme.setthemeData(0,context);
                  this.isDarkModeEnabled=isDarkModeEnabled;
                  setState(() {});
                },
              ),
              ListTile(
              onTap: (){
                try{
                  googleAuth.signOutWithGoogle().then((value){
                    if(value){
                      Navigator.pushNamed(context, '/login');
                    }else{
                      print('no');
                    }
                  });
                   faceAuth.signOut().then((value){
                     if(value){
                       Navigator.pushNamed(context, '/login');
                     }else{
                       print('no');
                     }
                   });
                }catch(e){
                  print(e);
                }
              },
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}