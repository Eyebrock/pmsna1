import 'package:flutter/material.dart';
import 'package:pmsna1/widgets/task_widget.dart';
import 'package:provider/provider.dart';

import '../database/database_helper.dart';
import '../models/event_model.dart';
import '../provider/flags_provider.dart';

class ListTasks extends StatefulWidget {
  const ListTasks({super.key});

  @override
  State<ListTasks> createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {

  DatabaseHelper? database;

   @override
  void initState() {
    super.initState();
    database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    FlagosProvider flags = Provider.of<FlagosProvider>(context);

    return 
    FutureBuilder(
      future: flags.getflagListPost() == true ? database!.GET_ALL_EVENTOS() : database!.GET_ALL_EVENTOS(),
      builder: (context, AsyncSnapshot<List<EventModel>> snapshot) {
        if( snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var objEventModel = snapshot.data![index];
              return TaskItemWidget(objEventModel: objEventModel);
            },
          );
        }else if(snapshot.hasError){
          return const Center(child: Text('Ocurrio un error'),);
        }else{
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}