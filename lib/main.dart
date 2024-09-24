import 'package:Notes/presentation/notes_page.dart';
import 'package:Notes/presentation/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/consts.dart';
import 'data/models/isar_note.dart';
import 'data/repo/isar_note_repo.dart';
import 'domain/note_repository.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);


  final prefs = await SharedPreferences.getInstance();
  var isDarkTheme = prefs.getBool(isDark);
  isDarkTheme ??= false;

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([IsarNoteSchema], directory: dir.path);
  final repo = IsarNoteRepo(db: isar);

  runApp(MyApp(repo: repo, isDark: isDarkTheme,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.repo, required this.isDark});

  final NoteRepository repo;
  final bool isDark;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(isDark: isDark),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (BuildContext context, theme) {

          return MaterialApp(

            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: theme.copyWith(textTheme: GoogleFonts.montserratTextTheme(theme.textTheme)),
            home: NotesPage(repo: repo,),

          );
        },

      ),
    );
  }
}


