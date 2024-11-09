import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/database_helper.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get notes => _notes;

  Future<void> loadNotes() async {
    _notes = await DatabaseHelper.instance.getNotes();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await DatabaseHelper.instance.addNote(note);
    await loadNotes();
  }

  Future<void> updateNote(Note note) async {
    await DatabaseHelper.instance.updateNote(note);
    await loadNotes();
  }

  Future<void> deleteNote(int id) async {
    await DatabaseHelper.instance.deleteNote(id);
    await loadNotes();
  }
}
