import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/database_helper.dart';
import '../models/event_model.dart';
import '../provider/flags_provider.dart';

class TaskItemWidget extends StatelessWidget {
  TaskItemWidget({Key? key, this.objEventModel}) : super(key: key);

  EventModel? objEventModel;

  final DatabaseHelper database = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final txtDesc = Text(objEventModel!.dscEvento!);
    final txttitle = Text(objEventModel!.ttlEvento!);
    final dateEvent = Text(objEventModel!.fechaEvento!.toString());

    final txtPostController = TextEditingController();
    if (ModalRoute.of(context)!.settings.arguments != null) {
      objEventModel = ModalRoute.of(context)!.settings.arguments as EventModel;
      txtPostController.text = objEventModel!.dscEvento!;
    }

    final txttittleController = TextEditingController();
    if (ModalRoute.of(context)!.settings.arguments != null) {
      objEventModel = ModalRoute.of(context)!.settings.arguments as EventModel;
      txtPostController.text = objEventModel!.ttlEvento!;
    }

    final FlagosProvider falg = Provider.of<FlagosProvider>(context);

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 190,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 204, 153, 210),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 15.0, // set the radius of the avatar
                backgroundImage: AssetImage('assets/todolist.png'),
                backgroundColor: Colors.white,
              ),
              const SizedBox(
                width: 20,
              ),
              txttitle,
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    txtDesc,
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              dateEvent,
              Expanded(child: Container()),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Actualiza la Tarea'),
                      content: SizedBox(
                        height: 200,
                        child: Column(
                          children: [
                            TextField(
                              controller: txttittleController,
                              decoration: InputDecoration(labelText: 'TItulo de la Tarea'),
                            ),
                            TextField(
                              controller: txtPostController,
                              decoration:
                                  InputDecoration(labelText: 'Descripción'),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            database.UPDATE_EVENTO({
                        'idEvento': objEventModel!.idEvento,
                        'ttlEvento': txttittleController.text,
                        'dscEvento': txtPostController.text,
                      }).then((value) {
                        var msg = value > 0 ? 'Registro actualizado' : 'Error';
                        var snackBar = SnackBar(content: Text(msg));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        falg.setFlagListPost();
                      });
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        )
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirmar el Borrado'),
                      content: const Text('Se borrara la tarea seleccionado'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            database
                                .DELETE_EVENTO(objEventModel!.idEvento!)
                                .then((value) => falg.setFlagListPost());
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        )
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete),
              )
            ],
          )
        ],
      ),
    );
  }
}
