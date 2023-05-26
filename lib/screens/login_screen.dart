import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pmsna1/firebase/email_authentication.dart';
import 'package:pmsna1/responsive.dart';
import 'package:pmsna1/widgets/loading_modal_widget.dart';
import 'package:provider/provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:pmsna1/provider/theme_provider.dart';

import '../firebase/facebook_autjentication.dart';
import '../firebase/google_authentication.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoadibg = false;

  Emailuth emailAuth = Emailuth();
  GoogleAuth googleAuth = GoogleAuth();
  FaceAuth faceAuth = FaceAuth();

  TextEditingController? emailtxt = TextEditingController();
  TextEditingController? passwordtxt = TextEditingController();

  final horizontalSpace = const SizedBox(
    height: 10,
  );

  final imageLogo = Image.asset(
    'assets/logoitc.png',
    height: 200,
  );

  @override
  Widget build(BuildContext context) {
    // Padding txtregister = botonregistro(context);
    // SocialLoginButton buttonlogging = botonlogin(context);

    final googlebtn = SocialLoginButton(
      buttonType: SocialLoginButtonType.google,
      onPressed: () async {
        isLoadibg = true;
        setState(() {});
        await googleAuth.signInWithGoogle().then((value) {
          if (value.name != null) {
            isLoadibg = false;
            Navigator.pushNamed(context, '/dash', arguments: value);
          } else {
            isLoadibg = false;
            setState(() {});
            SnackBar(
              content: Text('Verifica tus credenciales'),
            );
          }
        });
      },
    );

    final txtEmail = TextFormField(
      controller: emailtxt,
      decoration: const InputDecoration(
          label: Text("EMAIL USER"), border: OutlineInputBorder()),
    );

    final txtPass = TextFormField(
      controller: passwordtxt,
      decoration: const InputDecoration(
          label: Text("Password"), border: OutlineInputBorder()),
    );

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
                  tablet: _buildhorizontalContent(txtEmail, txtPass, googlebtn),
                  mobile: _buildMobileContent(txtEmail, txtPass, googlebtn),
                  desktop: _buildDesktopContent(txtEmail, txtPass, googlebtn)),
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
        // print(emailtxt!.text);
        // print(passwordtxt!.text);
        emailAuth
            .signInWithEmailAndPassword(
                email: emailtxt!.text, password: passwordtxt!.text)
            .then((value) {
          if (value) {
            Navigator.pushNamed(context, '/dash');
            isLoadibg = false;
          } else {
            isLoadibg = false;
            const SnackBar(
              content: Text('Verifica tus credenciales'),
            );
          }
        });
        isLoadibg = false;
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
      label: const Text('Theme Settings'),
      heroTag: 'GFG tag',
    );
    return themechange;
  }

  FloatingActionButton btncalendar(BuildContext context) {
    final calendarview = FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/Calendar');
      },
      backgroundColor: const Color.fromARGB(255, 2, 47, 84),
      child: const Icon(Icons.calendar_today),
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
        child: const Text(
          'crear una cuenta',
          style: TextStyle(fontSize: 18, decoration: TextDecoration.underline),
        ),
      ),
    );
    return txtregister;
  }

  Widget _buildFacebookButton() {
    return SocialLoginButton(
      buttonType: SocialLoginButtonType.facebook,
      onPressed: () async {
        isLoadibg = true;
        setState(() {});
        faceAuth.signInWithFacebook().then((value) {
          if (value.name != null) {
            Navigator.pushNamed(context, '/dash', arguments: value);
            isLoadibg = false;
          } else {
            isLoadibg = false;
            SnackBar(
              content: Text('Verifica tus credenciales'),
            );
          }
          setState(() {});
        });
      },
    );
  }

  Widget _buildMobileContent(TextFormField txtEmail, TextFormField txtPass,
      SocialLoginButton googlebtn) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 0,
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 50),
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
                const SizedBox(height: 10),
                txtEmail,
                const SizedBox(height: 10),
                txtPass,
                const SizedBox(height: 10),
                botonlogin(context),
                const SizedBox(height: 10),
                googlebtn,
                const SizedBox(height: 10),
                _buildFacebookButton(),
                const SizedBox(height: 10),
                btnonboard(context),
                const SizedBox(height: 10),
                botonregistro(context),
                const SizedBox(height: 10),
                btnthemech(context)
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildDesktopContent(TextFormField txtEmail, TextFormField txtPass,
      SocialLoginButton googlebtn) {
    final txtEmail = TextFormField(
      controller: emailtxt,
      decoration: const InputDecoration(
          label: Text("EMAIL USER"), border: OutlineInputBorder()),
    );

    final txtPass = TextFormField(
      controller: passwordtxt,
      decoration: const InputDecoration(
          label: Text("Password"), border: OutlineInputBorder()),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 50),
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
                  _buildFacebookButton(),
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

  Widget _buildhorizontalContent(TextFormField txtEmail, TextFormField txtPass,
      SocialLoginButton googlebtn) {
    final txtEmail = TextFormField(
      controller: emailtxt,
      decoration: const InputDecoration(
          label: Text("EMAIL USER"), border: OutlineInputBorder()),
    );

    final txtPass = TextFormField(
      controller: passwordtxt,
      decoration: const InputDecoration(
          label: Text("Password"), border: OutlineInputBorder()),
    );
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
                        _buildFacebookButton(),
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
                const SizedBox(height: 20),
                imageLogo,
                const SizedBox(height: 20),
                const SizedBox(height: 20),
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

  final horizontalSpace = const SizedBox(
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
