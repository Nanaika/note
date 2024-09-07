import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {super.key,
      required this.title,
      required this.leading,
      required this.onTap});

  final String title;
  final Widget leading;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 22),
      leading: leading,
      title: Text(
        title,
        style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Theme.of(context).colorScheme.inversePrimary),
      ),
      onTap: onTap,
    );
  }
}
