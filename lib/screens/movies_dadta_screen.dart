import 'package:flutter/material.dart';
import 'package:pmsna1/models/actor_model.dart';
import 'package:pmsna1/models/popular_model.dart';
import 'package:pmsna1/networks/api_popular.dart';
import 'package:pmsna1/widgets/actor_details.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDataScreen extends StatelessWidget {
  ApiPopular apiPopular = ApiPopular();

  final PopularModel model;
  MovieDataScreen({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.title!),
        centerTitle: true,
      ),
      body: Hero(
        tag: model.id!,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 250,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                    FutureBuilder(
                        future: apiPopular.getIdVideo(model!.id!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return YoutubePlayer(
                              controller: YoutubePlayerController(
                                initialVideoId: snapshot.data.toString(),
                                flags: const YoutubePlayerFlags(
                                    autoPlay: false,
                                    mute: false,
                                    controlsVisibleAtStart: true),
                              ),
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.red,
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10),
                        const Text(
                          'RATING:',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow
                          ),
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 50,
                        ),
                        Text(
                          model!.voteAverage.toString(),
                          style: const TextStyle(
                            color: Colors.yellow,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      'About:',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      model!.overview.toString(),
                      style: const TextStyle(
                          fontSize: 16,
                          backgroundColor: Color.fromARGB(200, 4, 45, 86)),
                    ),
                    const SizedBox(height: 20),
                    Row(),
                    const SizedBox(height: 20),
                    const Text(
                      'Actors',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder<List<ActorModel>?>(
                      future: apiPopular.getAllAuthors(model!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return SizedBox(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                ActorModel actor = snapshot.data![index];
                                return ActorCard(
                                  name: actor.name.toString(),
                                  photoUrl:
                                      'https://image.tmdb.org/t/p/original${actor.profilePath}',
                                );
                              },
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Movie Poster:',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.network(
                      'https://image.tmdb.org/t/p/w500/${model!.backdropPath}',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
