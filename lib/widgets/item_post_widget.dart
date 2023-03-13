
import 'package:flutter/material.dart';
import 'package:pmsna1/database/database_helper.dart';
import 'package:pmsna1/models/post_model.dart';
import 'package:pmsna1/provider/flags_provider.dart';
import 'package:provider/provider.dart';

class ItemPostWidget extends StatelessWidget {
   ItemPostWidget({super.key,this.objPostModel});

  PostModel? objPostModel;

  DatabaseHelper database = DatabaseHelper();

  @override
  Widget build(BuildContext context) {

    final avatar = const CircleAvatar(
      backgroundImage: AssetImage('assets/logoitc.png'),
    );

    final txtuser = const Text('Eyebrock');
    final datePost = const Text('fecha-de-hoy');
    final imgPost = const Image(image: AssetImage('assets/logoitc.png'), height: 100,);
    final txtDesc = const Text('bien harto teszzzzzzto');
    final iconRate = const Icon(Icons.rate_review_rounded);

    FlagosProvider falg = Provider.of<FlagosProvider>(context);

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 32, 86, 113),
      ),
      child: Column(
        children: [
          Row(
            children: [
              avatar,
              txtuser,
              datePost
            ],
          ),
          Row(
            children: [
              imgPost,
              txtDesc
            ],
          ),
          Row(
            children: [
              iconRate,
              Expanded(child: Container()),
              IconButton(onPressed: (){}, icon: const Icon(Icons.edit)),
              IconButton(onPressed: (){

                showDialog(context: context,
                 builder: (context) => AlertDialog(
                  title: const Text('Confirmar el Borrado'),
                  content: const Text('Se borrara el Post seleccionado'),
                  actions: [
                    TextButton(onPressed: (){
                      database.DELETE('tblPost',objPostModel!.idPost!).then((value) => falg.setFlagListPost());
                      Navigator.pop(context);
                    }, child: const Text('OK')
                    ),
                    TextButton(onPressed: (){

                    }, child: const Text('Cancel'))
                  ],
                 ));
              }, icon: const Icon(Icons.delete))

            ],
          )
        ],
      ),
    );
  }
}