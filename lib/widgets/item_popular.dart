import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pmsna1/models/popular_model.dart';
import 'package:pmsna1/provider/flags_provider.dart';
import 'package:pmsna1/database/database_helper.dart';

class ItemPopular extends StatefulWidget {
  ItemPopular({super.key, required this.popularModel});
  PopularModel popularModel;
  
  @override
  State<ItemPopular> createState() => _ItemPopularState();
}

class _ItemPopularState extends State<ItemPopular> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    FlagosProvider flags = Provider.of<FlagosProvider>(context);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FadeInImage(
              fit: BoxFit.fill,
              placeholder: AssetImage('assets/loading.gif'),
              // ignore: prefer_interpolation_to_compose_strings
              image: NetworkImage('https://image.tmdb.org/t/p/w500/' +
                  widget.popularModel.posterPath.toString()),
            ),
          ),
        ),
        Positioned(
          top: 0.0,
          right: 20,
          child: FutureBuilder(
              future: databaseHelper.searchPopular(widget.popularModel.id!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Material(
                    child: IconButton(
                      icon: const Icon(Icons.favorite),
                      color:snapshot.data!=true?Colors.white:Colors.red,
                      onPressed: () {
                        if(snapshot.data!=true){
                          databaseHelper.INSERTg('tblPopularFav', widget.popularModel!.toMap()).then((value) => flags.setFlagListPost());
                        }else{
                          databaseHelper.DELETEg('tblPopularFav', widget.popularModel.id!, 'id').then((value) => flags.setFlagListPost());
                        }
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ],
    );
  }
}