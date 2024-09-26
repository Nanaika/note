import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../domain/models/note.dart';
import 'components/custom_text_button.dart';
import 'components/my_drawer.dart';
import 'components/note_list_tile.dart';
import 'components/page_title.dart';
import 'note_cubit.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  var isFabVisible = true;

  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {

    controller.addListener(() {
      if(controller.offset > controller.position.maxScrollExtent && isFabVisible) {
        setState(() {
          isFabVisible = false;
        });
      } else if (controller.offset < controller.position.maxScrollExtent && !isFabVisible) {
        setState(() {
          isFabVisible = true;
        });
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      drawer: const MyDrawer(),
      body: SafeArea(
        child: Column(
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
                    controller: controller,
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
      ),
      floatingActionButton: isFabVisible ? FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        onPressed: () {
          addNewNote(context);
        },
      ) : null,
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
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context)
                        .colorScheme
                        .inversePrimary
                        .withOpacity(0.5)),
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
