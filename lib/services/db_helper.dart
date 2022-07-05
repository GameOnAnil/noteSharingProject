import 'dart:developer';
import 'dart:io';

import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/utils/program_list_constant.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  final String _subjectTable = 'subject_table';

  DbHelper._provideConstructor();
  static final DbHelper instance = DbHelper._provideConstructor();

  static Database? _database;
  Future<Database> get database async => _database ?? await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String myPath = p.join(documentsDirectory.path, 'notes.db');
    final db = await openDatabase(
      myPath,
      version: 1,
      onCreate: _onCreate,
    );

    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE $_subjectTable
      (id INTEGER PRIMARY KEY, 
      name TEXT,
      semester TEXT,
      program TEXT,
      notificationOn BOOLEAN)
      ''',
    );
    await populate(db);
  }

  Future<void> populate(Database db) async {
    for (var element in subjectList) {
      await db.insert(_subjectTable, element.toMap());
    }
  }

  Future<int?> insertSubject(Subject subject) async {
    try {
      log("insert");
      final db = await instance.database;
      final response = await db.insert(_subjectTable, subject.toMap());
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<int?> updateSubject(Subject subject) async {
    try {
      final db = await instance.database;
      final response = await db.update(_subjectTable, subject.toMap(),
          where: "id= ?", whereArgs: [subject.id]);
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<Subject>> getAllSub() async {
    final db = await instance.database;
    final mapResponse = await db.query(_subjectTable);
    final list = mapResponse.map((e) => Subject.fromMap(e)).toList();
    return list;
  }

  Future<List<Subject>> getSubByCategory(
      {required String program, required String semester}) async {
    Database db = await instance.database;
    var result = await db.query(
      _subjectTable,
      orderBy: 'id',
      where: "program=? and semester=?",
      whereArgs: [program, semester],
    );
    List<Subject> subList =
        result.isNotEmpty ? result.map((e) => Subject.fromMap(e)).toList() : [];
    return subList;
  }
}
