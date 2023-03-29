import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmsna1/firebase/email_authentication.dart';
import 'package:pmsna1/widgets/loading_modal_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:image_picker/image_picker.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {

  TextEditingController emailtxt = TextEditingController();
  TextEditingController passwordtxt = TextEditingController();

  Emailuth? emailauth;
  
  File? _image;

  // This is the image picker
  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final pickedImage = await _picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  

  

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final txtEmail = TextFormField(
      controller: emailtxt,
    keyboardType: TextInputType.emailAddress,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Por favor introduce informacion dentro del campo';
      }
      if (!value.contains('@')) {
        return 'Por favor introduce un correo valido';
      }
      return null;
    },
    decoration: const InputDecoration(
      label: Text("USER E/MAIL"),
      border: OutlineInputBorder(),
    ),
  );

    final txtNombre = TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Por favor Introduce infromacion dentro del campo';
      }
      return null;
    },
    decoration: const InputDecoration(
        label: Text("NOMBRE DEL USUARIO"), border: OutlineInputBorder()),
  );

  final txtPass = TextFormField(
    controller: passwordtxt,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Por favor Introduce infromacion dentro del campo';
      }
      return null;
    },
    decoration: const InputDecoration(
        label: Text("CONTRASENA"), border: OutlineInputBorder()),
  );

  final horizontalSpace = SizedBox(
    height: 10,
  );
  
    final profile = GestureDetector(
      onTap: _openImagePicker,
      child: CircleAvatar(
        radius: 100,
        backgroundImage: _image != null ? FileImage(_image!) : null,
        child: _image == null ? Icon(Icons.person) : null,
      ),
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
                    image: AssetImage('assets/fondo.jpg'))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        horizontalSpace,
                        profile,
                        horizontalSpace,
                        txtEmail,
                        horizontalSpace,
                        txtPass,
                        horizontalSpace,
                        txtNombre,
                        horizontalSpace,
                        Positioned(
                      bottom: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                             emailauth?.createUserWithEmailAndPassword(email: emailtxt.text, password: passwordtxt.text);
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //isLoadibg ? const LoadingModalWidget() : Container()
        ],
      ),
    );
  }
}
