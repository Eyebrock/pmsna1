import 'package:flutter/material.dart';
import 'package:pmsna1/models/popular_model.dart';
import 'package:pmsna1/networks/api_popular.dart';
import 'package:pmsna1/screens/movies_dadta_screen.dart';
import 'package:pmsna1/widgets/item_popular.dart';
import 'package:provider/provider.dart';
import '../database/database_helper.dart';
import '../provider/flags_provider.dart';

class ListPopularVideos extends StatefulWidget {
  const ListPopularVideos({super.key});

  @override
  State<ListPopularVideos> createState() => _ListPopularVideosState();
}

class _ListPopularVideosState extends State<ListPopularVideos> {
  ApiPopular? apiPopular;
  bool isFavoriteView = false;
  DatabaseHelper? database;

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
    database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    FlagosProvider flag = Provider.of<FlagosProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Popular Movies'),
        actions: [
          IconButton(
            icon: isFavoriteView != true
                ? Icon(Icons.star_border)
                : Icon(Icons.list),
            onPressed: () {
              setState(() {
                isFavoriteView = !isFavoriteView;
              });
            },
          )
        ],
      ),
      body: FutureBuilder(
          future: flag.getflagListPost() == true
              ? isFavoriteView
                  ? database!.getAllPopular()
                  : apiPopular!.getAllPopular()
              : isFavoriteView
                  ? database!.getAllPopular()
                  : apiPopular!.getAllPopular(),
          builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: snapshot.data != null ? snapshot.data!.length : 0,
                itemBuilder: (context, index) {
                  PopularModel model = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => MovieDataScreen (
                            model: snapshot.data![index],
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: snapshot.data![index].id!,
                      child: ItemPopular(popularModel: snapshot.data![index]),
                    ),
                  );

                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('OCURRIO UN ERROR${snapshot.error}'),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
