import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesFirebase{
  FirebaseFirestore? _fire;
  CollectionReference? _favoriteCollection;
  FavoritesFirebase(){
    _fire=FirebaseFirestore.instance;
    _favoriteCollection=_fire!.collection('favorites');
  }

  Future<void> insertFvourite(Map<String,dynamic> map) async {
    return _favoriteCollection!.doc().set(map);
  }

  Future<void> updFavourite(Map<String,dynamic> map, String id) async{
    return _favoriteCollection!.doc(id).update(map);
  }

  Future<void> delFavourite(String id) async {
    return _favoriteCollection!.doc(id).delete();
  }

  Stream<QuerySnapshot> getAllFavorites(){
    return _favoriteCollection!.snapshots();
  }
  
}