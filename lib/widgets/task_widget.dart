import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/database_helper.dart';
import '../models/event_model.dart';
import '../provider/flags_provider.dart';

class TaskItemWidget extends StatelessWidget {
  TaskItemWidget({super.key, this.objEventModel});

  EventModel? objEventModel;

  DatabaseHelper database = DatabaseHelper();

  @override
  Widget build(BuildContext context) {

    final txtDesc =  Text(objEventModel!.dscEvento!);
    final txttitle = Text(objEventModel!.ttlEvento!);
    final dateEvent = Text(objEventModel!.fechaEvento!.toString());
    
    FlagosProvider falg = Provider.of<FlagosProvider>(context);
    
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
             radius: 50.0, // set the radius of the avatar
            backgroundImage: AssetImage('assets/todolist.png'),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                txttitle,
                const SizedBox(
                  height: 5,
                ),
                txtDesc,
                const SizedBox(
                  height: 5,
                ),
                dateEvent,
              ],
            ),
          ),
          Row(
            children: [
              Expanded(child: Container()),
              IconButton(onPressed: (){
                
              }, icon: const Icon(Icons.edit)),
              IconButton(onPressed: (){
                showDialog(context: context,
                 builder: (context) => AlertDialog(
                  title: const Text('Confirmar el Borrado'),
                  content: const Text('Se borrara la tarea seleccionado'),
                  actions: [
                    TextButton(onPressed: (){
                      database.DELETE_EVENTO(objEventModel!.idEvento!).then((value) => falg.setFlagListPost());
                      // database.DELETE('tblPost',objPostModel!.idPost!).then((value) => falg.setFlagListPost());
                      Navigator.pop(context);
                    }, child: const Text('OK')
                    ),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
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
