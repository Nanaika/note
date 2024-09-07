import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    super.key, required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,

      style: GoogleFonts.montserrat(
        fontSize: 38,
        fontWeight: FontWeight.w200,
        color: Theme.of(context).colorScheme.inversePrimary
      ),
    );
  }
}