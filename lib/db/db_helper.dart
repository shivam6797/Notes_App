import 'dart:io';
import 'package:notes_app/model/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  // make this class constructor is private
  // private constructor
  DbHelper._();
  static DbHelper getInstance() => DbHelper._();
  static String TABLE_NOTE = "notes";
  static String COLUMN_NOTE_ID = "nId";
  static String COLUMN_NOTE_TITLE = "nTitle";
  static String COLUMN_NOTE_DESC = "nDesc";
  static String COLUMN_NOTE_CREATED_AT = "ncreatedAt";

  // DB will only be created once, it will be destroyed only when user clear the cache
  // data or uninstall the app.

  //  this path is android path and this path normal users access this path
  // Will always open the DB, (database path => "data/data/www.something.com/databases/dbname.db")
  //  it it exists we will open it, and
  //imp. if it does not exist we will created and then open it.
  Database? _db;

  Future<Database> getDB() async {
    // handle null db like this using nullable operator
    _db ??= await openDB();
    return _db!;
    //  it's if/else condition check
    // if(_db!= null){
    //   return _db!;
    // }else{
    //   _db = await openDB();
    //   return _db!;
    // }
  }

  Future<Database> openDB() async {
    Directory appdocDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(appdocDirectory.path, "noteDB.db");
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        // create tables
        db.execute(
            "CREATE TABLE $TABLE_NOTE ($COLUMN_NOTE_ID integer primary key autoincrement, $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text, $COLUMN_NOTE_CREATED_AT text)");
      },
    );
  }

  Future<bool> addNote({required NoteModel newNote}) async {
    Database db = await getDB();
    int rowsEffected = await db.insert(TABLE_NOTE, newNote.toMap());
    return rowsEffected > 0;
  }

  Future<List<NoteModel>> fetchAllNotes() async {
    var db = await getDB();
    List<Map<String, dynamic>> mNotes = await db.query(TABLE_NOTE);
    /// select * from $TABLE_NOTE
    List<NoteModel> allNotes = [];
    for (Map<String, dynamic> eachNote in mNotes){
      allNotes.add(NoteModel.fromMap(eachNote));
    }
    return allNotes;
  }

  Future<bool> updateNote(NoteModel updatedNote) async {
    var db = await getDB();
    int rowsEffected = await db.update(TABLE_NOTE, updatedNote.toMap(),
        where: "$COLUMN_NOTE_ID = ?", whereArgs: ["${updatedNote.nId}"]);
    return rowsEffected > 0;
  }

  Future<bool> deleteNote(int id) async {
    var db = await getDB();
    int rowsEffected =
        await db.delete(TABLE_NOTE, where: "$COLUMN_NOTE_ID = $id");
    return rowsEffected > 0;
  }
}
