import 'package:isar/isar.dart';
import 'package:notes/data/models/isar_note.dart';
import 'package:notes/domain/models/note.dart';
import 'package:notes/domain/note_repository.dart';

class IsarNoteRepo implements NoteRepository {
  final Isar db;

  IsarNoteRepo({required this.db});

  @override
  Future<void> delete(Note note) async {
    return db.writeTxn(() => db.isarNotes.delete(note.id));
  }

  @override
  Future<List<Note>> getAll() async {
    final notes = await db.isarNotes.where().findAll();
    return notes.map((element) => element.toDomain()).toList();
  }

  @override
  Future<void> save(Note note) async {
    return db.writeTxn(() => db.isarNotes.put(IsarNote().fromDomain(note)));

  }

  @override
  Future<void> update(int id, String newText) async {
    final isarNote = await db.isarNotes.get(id);
    isarNote?.description = newText;
    return db.writeTxn(() => db.isarNotes.put(isarNote!));
  }
}
