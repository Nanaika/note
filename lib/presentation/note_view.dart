import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/domain/models/note.dart';
import 'package:notes/presentation/note_cubit.dart';
import 'package:notes/presentation/theme/theme_cubit.dart';

import 'components/custom_text_button.dart';
import 'components/my_drawer.dart';
import 'components/note_list_tile.dart';
import 'components/page_title.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       context.read<ThemeCubit>().switchTheme();
        //     },
        //     icon: BlocBuilder<ThemeCubit, ThemeData>(
        //       builder: (BuildContext context, state) {
        //         var themeCubit = context.read<ThemeCubit>();
        //         final icon = themeCubit.isDark
        //             ? CupertinoIcons.sun_max_fill
        //             : CupertinoIcons.moon_fill;
        //         return Icon(
        //           icon,
        //           color: Theme.of(context).colorScheme.inversePrimary,
        //           size: 18,
        //         );
        //       },
        //     ),
        //   ),
        // ],
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: PageTitle(
              title: "Notes",
            ),
          ),
          Expanded(
            child: BlocBuilder<NoteCubit, List<Note>>(
              builder: (BuildContext context, notes) {
                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return NoteListTile(
                      note: note,
                      update: () {
                        editNote(context, note);
                      },
                      delete: () {
                        deleteNote(context, note);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          // backgroundColor: Colors.blue,
          child: const Icon(
            Icons.add,
          ),
          onPressed: () {
            addNewNote(context);
          }),
    );
  }

  void addNewNote(BuildContext context) {
    final cubit = context.read<NoteCubit>();
    final textController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              CustomTextButton(
                color: Theme.of(context).colorScheme.inversePrimary,
                text: 'SAVE',
                onPressed: () {
                  final note = Note(
                    id: DateTime.now().millisecondsSinceEpoch,
                    description: textController.text,
                    date: DateTime.now(),
                  );
                  cubit.create(note);
                  Navigator.pop(context);
                },
              ),
              CustomTextButton(
                color: Theme.of(context).colorScheme.inversePrimary,
                text: 'CANCEL',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
            title: const Text("New note"),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            content: TextField(
              minLines: 1,
              maxLines: 900,
              controller: textController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                isDense: true,
                hintText: "Enter note message here",
                hintStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.5)),
              ),
            ),
          );
        });
  }

  void editNote(BuildContext context, Note note) {
    final cubit = context.read<NoteCubit>();
    final textController = TextEditingController();
    textController.text = note.description;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              CustomTextButton(
                color: Theme.of(context).colorScheme.inversePrimary,
                text: 'SAVE',
                onPressed: () {
                  cubit.update(note.id, textController.text);
                  Navigator.pop(context);
                },
              ),
              CustomTextButton(
                color: Theme.of(context).colorScheme.inversePrimary,
                text: 'CANCEL',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
            title: const Text("Edit note"),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            content: TextField(
              minLines: 1,
              maxLines: 900,
              controller: textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                isDense: true,
                hintText: "Enter note message here",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          );
        });
  }

  void deleteNote(BuildContext context, Note note) {
    final cubit = context.read<NoteCubit>();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              CustomTextButton(
                color: Colors.red,
                text: 'DELETE',
                onPressed: () {
                  cubit.delete(note);
                  Navigator.pop(context);
                },
              ),
              CustomTextButton(
                color: Theme.of(context).colorScheme.inversePrimary,
                text: 'CANCEL',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
            title: const Text("Delete note?"),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
          );
        });
  }
}
