import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/note_repository.dart';
import 'note_cubit.dart';
import 'note_view.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key, required this.repo});

  final NoteRepository repo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteCubit(repo: repo),
      child: const NoteView(),
    );
  }
}


