import 'package:flutter/material.dart';
import 'package:pmsna1/database/database_helper.dart';

class AddPostScreen extends StatelessWidget {
   AddPostScreen({super.key});

  DatabaseHelper database = DatabaseHelper();


  @override
  Widget build(BuildContext context) {

    final txtconPost = TextEditingController();

    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(15),
          height: 350,
          decoration: BoxDecoration(
            color: Color.fromARGB(200, 214, 40, 127),
            border: Border.all(color: Color.fromARGB(255, 0, 0, 0))),
          child: Column(
            children: [
              const Text("Add Post Here"),
              TextFormField(
                controller: txtconPost,
                maxLines: 8,
              ),
              ElevatedButton(onPressed: (){
                database.INSERT('tblPost',{
                  'dscPost' : txtconPost.text,
                 'datePost' : DateTime.now().toString()
                }).then((value){
                  var msg = value > 0
                  ? 'Registro Insertado'
                  : 'Ocurrio un Error';

                  var snackBar = SnackBar(
                    content: Text(msg));

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              }, child: Text("Save Post"))
            ],
          ),
        ),
      ),
    );
  }
}