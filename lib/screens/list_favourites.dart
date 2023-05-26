import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pmsna1/firebase/favorites_firebase.dart';

class ListFvouritesCloud extends StatefulWidget {
  const ListFvouritesCloud({super.key});

  @override
  State<ListFvouritesCloud> createState() => _ListFvouritesCloudState();
}

class _ListFvouritesCloudState extends State<ListFvouritesCloud> {
  FavoritesFirebase _firebase = FavoritesFirebase();

  @override
  Widget build(BuildContext context) {
    FavoritesFirebase _firebase = FavoritesFirebase();
    return Scaffold(
      body: StreamBuilder(
        stream: _firebase.getAllFavorites(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Container(
                      child: ListView(
                    children: [
                      Text(snapshot.data!.docs[index].get('title')),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                _firebase.insertFvourite({
                                  'title' : snapshot.data!.docs[index].get('tittle'),
                                });
                              }, icon: const Icon(Icons.favorite)),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text(
                                              'Confirmar el Borrado'),
                                          content: const Text(
                                              'Se borrara el Post seleccionado'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  _firebase.delFavourite(snapshot.data!.docs[index].id);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('OK')),
                                            TextButton(
                                                onPressed: () {},
                                                child: const Text('Cancel'))
                                          ],
                                        ));
                              },
                              icon: const Icon(Icons.delete))
                        ],
                      )
                    ],
                  ));
                });
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error en la petición, intente de nuevo más tarde'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

//TODO: TERMINAR ESTE CODIGO EN CONJUNTO CON EL APARTADO DE FAVORITOS DE BASE DE DATOS, CHECAR ESO CON JORGE Y JOSE
