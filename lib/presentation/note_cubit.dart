import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/models/note.dart';
import '../domain/note_repository.dart';

class NoteCubit extends Cubit<List<Note>> {
  NoteCubit({required this.repo}) : super([]) {
    getAllNotes();
  }

  final NoteRepository repo;

  Future<void> getAllNotes() async {
    final notes = await repo.getAll();
    emit(notes);
  }
  Future<void> delete(Note note) async {
    await repo.delete(note);
    getAllNotes();
  }
  Future<void> update(int id, String newDescription) async {
    await repo.update(id, newDescription);
    getAllNotes();
  }
  Future<void> create(Note note) async {
    await repo.save(note);
    getAllNotes();
  }
}
