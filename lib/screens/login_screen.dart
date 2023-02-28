import 'package:flutter/material.dart';
import 'package:pmsna1/responsive.dart';
import 'package:pmsna1/widgets/loading_modal_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

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
    'assets/pepefalcon.jpg',
    height: 300
    ,
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
                    image: AssetImage('assets/chunky.jpg'))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Responsive(
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
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/register');
        },
        child: Text(
          'crear una cuenta',
          style: TextStyle(fontSize: 20, decoration: TextDecoration.underline),
        ),
      ),
    );
    return txtregister;
  }

  Widget _buildMobileContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FractionallySizedBox(
          child: imageLogo,
        ),
        horizontalSpace,
        horizontalSpace,
        txtEmail,
        horizontalSpace,
        txtPass,
        horizontalSpace,
        botonlogin(context),
        horizontalSpace,
        googlebtn,
        horizontalSpace,
        botonregistro(context),
        horizontalSpace,
        btnonboard(context),
        horizontalSpace,
        horizontalSpace,
      ],
    );
  }

  Widget _buildDesktopContent() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imageLogo
          ],
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
                  horizontalSpace
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
