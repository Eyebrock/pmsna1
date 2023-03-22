import 'package:flutter/material.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:pmsna1/provider/theme_provider.dart';
import 'package:pmsna1/screens/list_post.dart';
import 'package:provider/provider.dart';
import 'package:pmsna1/settings/styles_settings.dart';


class DashboardScreen extends StatefulWidget {

  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
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
            const UserAccountsDrawerHeader(
              currentAccountPicture:CircleAvatar(
                backgroundImage: NetworkImage('https://www.seekpng.com/png/full/966-9665493_my-profile-icon-blank-profile-image-circle.png'),
              ),
              accountName:Text('Eyebrock'),
              accountEmail: Text('eyebrock2913@gmail.com')
              ),
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
          ],
        ),
      ),
    );
  }
}