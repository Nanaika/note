
import 'models/note.dart';

abstract class NoteRepository {
  Future<void> save(Note note);
  Future<void> delete(Note note);
  Future<void> update(int id, String newDescription);
  Future<List<Note>> getAll();

}