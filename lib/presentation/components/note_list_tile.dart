import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/models/note.dart';

class NoteListTile extends StatelessWidget {
  const NoteListTile({
    super.key,
    required this.note,
    required this.update,
    required this.delete,
  });

  final Note note;
  final Function() update;
  final Function() delete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(left: 18, right: 18, top: 8),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left: 12, right: 12),
            title: Text(
              // maxLines: 2,
              // overflow: TextOverflow.ellipsis,
              note.description,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.w300,
              ),
            ),

            // trailing: ,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Text(
                      DateFormat('dd.MM.yyyy – kk:mm').format(note.date),
                      style: GoogleFonts.montserrat(
                        fontSize: 11,
                        color:
                        Theme.of(context).colorScheme.inversePrimary.withOpacity(0.6),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  IconButton(
                    onPressed: update,
                    icon: Icon(
                      CupertinoIcons.pen,
                      size: 22,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: delete,
                    icon: const Icon(
                      CupertinoIcons.delete,
                      size: 20,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
