import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pmsna1/responsive.dart';
import 'package:pmsna1/widgets/loading_modal_widget.dart';
import 'package:provider/provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:pmsna1/provider/theme_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoadibg = false;

  final txtEmail = TextFormField(
    decoration: const InputDecoration(
        label: Text("EMAIL USER"), border: OutlineInputBorder()),
  );

  final txtPass = TextFormField(
    decoration: const InputDecoration(
        label: Text("Password"), border: OutlineInputBorder()),
  );

  final horizontalSpace = SizedBox(
    height: 10,
  );

  final googlebtn = SocialLoginButton(
    buttonType: SocialLoginButtonType.twitter,
    onPressed: () {},
  );

  final imageLogo = Image.asset(
    'assets/logoitc.png',
    height: 200,
  );

  @override
  Widget build(BuildContext context) {
    Padding txtregister = botonregistro(context);

    SocialLoginButton buttonlogging = botonlogin(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    opacity: .5,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/green.jpg'))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Responsive(
                  tablet: _buildhorizontalContent(),
                  mobile: _buildMobileContent(),
                  desktop: _buildDesktopContent()),
            ),
          ),
          isLoadibg ? const LoadingModalWidget() : Container()
        ],
      ),
    );
  }

  SocialLoginButton botonlogin(BuildContext context) {
    final buttonlogging = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin,
      onPressed: () {
        isLoadibg = true;
        setState(() {});
        Future.delayed(Duration(milliseconds: 4000)).then((value) {
          isLoadibg = false;
          setState(() {});
          Navigator.pushNamed(context, '/dash');
        });
      },
    );
    return buttonlogging;
  }

  FloatingActionButton btnthemech(BuildContext context) {
    final themechange = FloatingActionButton.extended(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      onPressed: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const NewScreen())),
      label: Text('Theme Settings'),
      heroTag: 'GFG tag',
    );
    return themechange;
  }

  FloatingActionButton btncalendar(BuildContext context) {
    final calendarview = FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/Calendar');
      },
      backgroundColor: Color.fromARGB(255, 2, 47, 84),
      child: Icon(Icons.calendar_today),
    );
    return calendarview;
  }

  SocialLoginButton btnonboard(BuildContext context) {
    final buttonlogging = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin,
      text: 'Conocenos mas',
      onPressed: () {
        Navigator.pushNamed(context, '/Onb');
      },
    );
    return buttonlogging;
  }

  Padding botonregistro(BuildContext context) {
    final txtregister = Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/register');
        },
        child: Text(
          'crear una cuenta',
          style: TextStyle(fontSize: 18, decoration: TextDecoration.underline),
        ),
      ),
    );
    return txtregister;
  }

  Widget _buildMobileContent() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        flex: 0,
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 50),
            child: btncalendar(context),
          ),
        ),
      ),
      imageLogo,
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              txtEmail,
              SizedBox(height: 10),
              txtPass,
              SizedBox(height: 10),
              botonlogin(context),
              SizedBox(height: 10),
              googlebtn,
              SizedBox(height: 10),
              btnonboard(context),
              SizedBox(height: 10),
              botonregistro(context),
              SizedBox(height: 10),
              btnthemech(context)
            ],
          ),
        ),
      )
    ],
  );
}



  Widget _buildDesktopContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              child: btncalendar(context),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [imageLogo],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  horizontalSpace,
                  txtEmail,
                  horizontalSpace,
                  txtPass,
                  horizontalSpace,
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  horizontalSpace,
                  botonlogin(context),
                  horizontalSpace,
                  googlebtn,
                  horizontalSpace,
                  botonregistro(context),
                  horizontalSpace,
                  btnonboard(context),
                  horizontalSpace,
                  btnthemech(context)
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildhorizontalContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Espacio entre la imagen y los elementos
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        horizontalSpace,
                        horizontalSpace,
                        horizontalSpace,
                        horizontalSpace,
                        horizontalSpace,
                        horizontalSpace,
                        txtEmail,
                        horizontalSpace,
                        txtPass,
                        horizontalSpace,
                        googlebtn,
                        horizontalSpace,
                        botonlogin(context),
                        horizontalSpace,
                        btnonboard(context),
                        horizontalSpace,
                        btnthemech(context),
                        horizontalSpace,
                        botonregistro(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(height: 20),
                imageLogo,
                SizedBox(height: 20),
                SizedBox(height: 20),
                btncalendar(context),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class NewScreen extends StatefulWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  TextEditingController textEditingController = TextEditingController();

  ElevatedButton btnlight(BuildContext context) {
    final themechange = ElevatedButton.icon(
      onPressed: () {
        ThemeProvider theme =
            Provider.of<ThemeProvider>(context, listen: false);
        theme.setthemeData(0, context);
      },
      icon: const Icon(Icons.settings),
      label: const Text('Theme Light'),
    );
    return themechange;
  }

  ElevatedButton btndark(BuildContext context) {
    final themechange = ElevatedButton.icon(
      onPressed: () {
        ThemeProvider theme =
            Provider.of<ThemeProvider>(context, listen: false);
        theme.setthemeData(1, context);
      },
      icon: const Icon(Icons.settings),
      label: const Text('Theme Dark'),
    );
    return themechange;
  }

  ElevatedButton btncustom(BuildContext context) {
    final themechange = ElevatedButton.icon(
      onPressed: () {
        ThemeProvider theme =
            Provider.of<ThemeProvider>(context, listen: false);
        theme.setthemeData(2, context);
      },
      icon: const Icon(Icons.settings),
      label: const Text('Theme Custom'),
    );
    return themechange;
  }

  final horizontalSpace = SizedBox(
    height: 10,
  );

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Theme Selector'),
      ),
      body: Center(
        child: Hero(tag: 'GFG Tag', child: _buildthememenu()),
      ),
    );
  }

  Widget _buildthememenu() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        horizontalSpace,
        btncustom(context),
        horizontalSpace,
        btnlight(context),
        horizontalSpace,
        btndark(context)
      ],
    );
  }
}
