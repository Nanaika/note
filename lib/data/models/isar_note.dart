import 'package:isar/isar.dart';
import 'package:notes/domain/models/note.dart';

part 'isar_note.g.dart';

@collection
class IsarNote {
  Id id = Isar.autoIncrement;
  late String description;
  late DateTime date;

  Note toDomain() {
    return Note(id: id, description: description, date: date);
  }

  IsarNote fromDomain(Note note) {
    return IsarNote()
      ..id = note.id
      ..description = note.description
      ..date = note.date;
  }
}
