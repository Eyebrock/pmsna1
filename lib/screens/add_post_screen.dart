import 'package:flutter/material.dart';
import 'package:pmsna1/database/database_helper.dart';
import 'package:pmsna1/provider/flags_provider.dart';
import 'package:provider/provider.dart';

import '../models/post_model.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});
  DatabaseHelper database = DatabaseHelper();
  PostModel? objPostModel;

  @override
  Widget build(BuildContext context) {

    FlagosProvider falg = Provider.of<FlagosProvider>(context);
    
    final txtPostController = TextEditingController();
    if (ModalRoute.of(context)!.settings.arguments != null) {
      objPostModel = ModalRoute.of(context)!.settings.arguments as PostModel;
      txtPostController.text = objPostModel!.dscPost!;
    }

    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(15),
          height: 350,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black), color: Colors.green),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              objPostModel == null
                  ? const Text('Agregar publicación')
                  : const Text('Actualizar publicación'),
              TextFormField(
                maxLines: 8,
                controller: txtPostController,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (objPostModel == null) {
                      database.INSERT('tblPost', {
                        'dscPost': txtPostController.text,
                        'datePost': DateTime.now().toString()
                      }).then((value) {
                        var msg = value > 0 ? 'Registro insertado' : 'Error';
                        var snackBar = SnackBar(content: Text(msg));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    } else {
                      database.UPDATE('tblPost', {
                        'idPost': objPostModel!.idPost,
                        'dscPost': txtPostController.text,
                        'datePost': DateTime.now().toString()
                      }).then((value) {
                        var msg = value > 0 ? 'Registro actualizado' : 'Error';
                        var snackBar = SnackBar(content: Text(msg));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }
                  },
                  child: const Text('Guardar'))
            ],
          ),
        ),
      ),
    );
  }
}