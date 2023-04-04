import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:pmsna1/models/event_model.dart';
import 'package:pmsna1/routes.dart';
import 'package:sqflite/sqflite.dart';

import '../models/popular_model.dart';
import '../models/post_model.dart';

class DatabaseHelper {
  static final nameDB = 'SOCIALDB';
  static final versionDB = 4;

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    return await openDatabase(
      pathDB,
      version: versionDB,
      onCreate: _createTables,
    );
  }

  _createTables(Database db, int version) async {
    String query = '''CREATE TABLE tblPost(
      idPost INTEGER PRIMARY KEY,
      dscPost VARCHAR(200),
      datePost DATE
    )''';

    String query2 = '''CREATE TABLE eventos(
      idEvento INTEGER PRIMARY KEY,
      ttlEvento VARCHAR(200),
      dscEvento VARCHAR(200),
      fechaEvento DATE,
      completado INTEGER
    )''';

    String query3 = '''
      CREATE TABLE tblPopularFav (
        backdrop_path TEXT,
        id INTEGER,
        original_language TEXT,
        original_title TEXT,
        overview TEXT,
        popularity REAL,
        poster_path TEXT,
        release_date TEXT,
        title TEXT,
        vote_average REAL,
        vote_count INTEGER
      );
    ''';

    db.execute(query);
    db.execute(query2);
    db.execute(query3);
  }

  //EVENTOS PARA LA TABLA DE POSTS
  Future<int> INSERT(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion.insert(tblName, data);
  }

  Future<int> UPDATE(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion
        .update(tblName, data, where: 'idPost=?', whereArgs: [data['idPost']]);
  }

  Future<int> DELETE(String tblName, int idPost) async {
    var conexion = await database;
    return conexion.delete(tblName, where: 'idPost =?', whereArgs: [idPost]);
  }

  Future<List<PostModel>> GETALLPOST() async {
    var conexion = await database;
    var result = await conexion.query('tblPost');
    return result.map((post) => PostModel.fromMap(post)).toList();
  }

  //EVENTOS PARA LA TABLA DE EVENTOS
  Future<int> INSERT_EVENTO(Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion.insert('eventos', data);
  }

  Future<int> UPDATE_EVENTO(Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion.update('eventos', data,
        where: 'idEvento=?', whereArgs: [data['idEvento']]);
  }

  Future<int> DELETE_EVENTO(int idEvento) async {
    var conexion = await database;
    return conexion
        .delete('eventos', where: 'idEvento =?', whereArgs: [idEvento]);
  }

  Future<List<EventModel>> GET_ALL_EVENTOS() async {
    var conexion = await database;
    var result = await conexion.query('eventos');
    return result.map((post) => EventModel.fromMap(post)).toList();
  }

  Future<List<PopularModel>> getAllPopular() async {
    var conexion = await database;
    var result = await conexion.query('tblPopularFav');
    return result.map((popular) => PopularModel.fromMap(popular)).toList();
  }

  Future<bool> searchPopular(int id_popular) async {
    var conexion = await database;
    var query = "SELECT * FROM tblPopularFav where id=?";
    var result = await conexion.rawQuery(query, [id_popular]);
    if (result != null && result.isNotEmpty) {
      return true;
    }
    return false;
  }
  //////PELICULAS
  
  Future<int> INSERTg(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return await conexion.insert(tblName, data);
  }

  Future<int> UPDATEg(
      String tblName, Map<String, dynamic> data, String idColumnName) async {
    var conexion = await database;
    return await conexion.update(
      tblName,
      data,
      where: '$idColumnName = ?',
      whereArgs: [data[idColumnName]],
    );
  }

  Future<int> DELETEg(String tblName, int id, String idColumnName) async {
    var conexion = await database;
    return await conexion.delete(
      tblName,
      where: '$idColumnName = ?',
      whereArgs: [id],
    );
  }
}
