import 'package:flutter/cupertino.dart';
import 'package:notes_app/db/db_helper.dart';
import 'package:notes_app/model/note_model.dart';

class DbProvider extends ChangeNotifier {
  DbHelper dbHelper;
  DbProvider({required this.dbHelper});
  List<NoteModel> _mNotes = [];

  List<NoteModel> getAllNotes() => _mNotes;

  void addNote(NoteModel newNote) async {
    bool check = await dbHelper.addNote(newNote: newNote);
    if (check) {
      _mNotes = await dbHelper.fetchAllNotes();
      notifyListeners();
    }
  }

  void fetchInitialData() async {
    _mNotes = await dbHelper.fetchAllNotes();
    notifyListeners();
  }

  void updateNote(NoteModel updatedNote) async {
    bool check = await dbHelper.updateNote(updatedNote);
    if (check) {
      _mNotes = await dbHelper.fetchAllNotes();
      notifyListeners();
    }
  }

  void deleteNote(int id)async{
    bool check = await dbHelper.deleteNote(id);
    if(check){
      _mNotes = await dbHelper.fetchAllNotes();
      notifyListeners();
    }
  }
}
