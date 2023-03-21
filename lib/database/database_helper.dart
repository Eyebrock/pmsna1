import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:pmsna1/models/event_model.dart';
import 'package:pmsna1/routes.dart';
import 'package:sqflite/sqflite.dart';

import '../models/post_model.dart';

class DatabaseHelper {
  static final nameDB = 'SOCIALDB';
  static final versionDB = 3;

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

    db.execute(query);
    db.execute(query2);
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
}
