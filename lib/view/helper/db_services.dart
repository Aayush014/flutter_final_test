import 'package:flutter_final_test/view/modal/notes_modal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbService {

  static DbService dbService = DbService._();
  DbService._();
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    Database data = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String base =
            'CREATE TABLE Notes (id INTEGER PRIMARY KEY AUTOINCREMENT, notes TEXT,description TEXT, like INTEGER)';
        await db.execute(base);
      },
    );
    return data;
  }

  Future<void> insertData(NotesModal note)
  async {
    List notes =[note.note,note.description,note.like];
    final data = await database;
    String sql = 'INSERT INTO Notes(notes, description, like) VALUES(?,?,?)';
    data!.rawInsert(sql,notes);
  }

  Future<List> selectedNotes()
  async {
    final data = await database;
    String sql = 'SELECT * FROM Notes';
    List notes = await data!.rawQuery(sql);
    return notes;
  }

  Future<void> removeNotes(String note)
  async {
    final data = await database;
    String sql = 'DELETE FROM Notes WHERE notes = ?';
    data!.rawDelete(sql,[note]);
  }
}
