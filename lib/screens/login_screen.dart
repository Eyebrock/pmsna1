import 'package:flutter/material.dart';
import 'package:pmsna1/widgets/loading_modal_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isLoadibg=false;

  final txtEmail = TextFormField(
    decoration: const InputDecoration(
      label: Text("EMAIL USER"),
      border: OutlineInputBorder()
    ),
  );


  final txtPass = TextFormField(
    decoration:const InputDecoration(
      label: Text("Password"),
      border: OutlineInputBorder()
    ),
  );
  
  final horizontalSpace = SizedBox(height: 10,);


  final googlebtn = SocialLoginButton(
    buttonType: SocialLoginButtonType.twitter, 
    onPressed: (){},
    );

    final imageLogo = Image.asset('assets/pepefalcon.jpg', height: 200,); 

  @override
  Widget build(BuildContext context) {

    
    final txtregister = Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
      onPressed: (){
        Navigator.pushNamed(context, '/register');
      },
      child: Text('crear una cuenta', style: TextStyle(
        fontSize: 20,
        decoration: TextDecoration.underline
      ),
      ),
      ),
    );

    final buttonlogging = SocialLoginButton(
    buttonType: SocialLoginButtonType.generalLogin, 
    onPressed: (){
      isLoadibg = true;
      setState(() {});
      Future.delayed(Duration(milliseconds: 4000)).then((value){
        isLoadibg = false;
        setState(() {});
        Navigator.pushNamed(context, '/dash');
      });
    },
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
                image: AssetImage('assets/chunky.jpg'))
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      horizontalSpace,
                      txtEmail,
                      horizontalSpace,
                      txtPass,
                      horizontalSpace,
                      buttonlogging,
                      horizontalSpace,
                      googlebtn,
                      horizontalSpace,
                      txtregister
                    ],
                  ),
                  Positioned(
                    top: 100,
                    child:imageLogo,)
                ],
              ),
            ),
          ),
          isLoadibg ? const LoadingModalWidget() : Container()
        ],
      ),
    );
  }
}