import 'package:Notes/presentation/theme/theme_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/consts.dart';
import 'components/page_title.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: PageTitle(
                title: "Settings",
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, top: 24.0, right: 18.0),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Dark mode",
                              style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Theme.of(context).colorScheme.inversePrimary
                              ),
                          ),
                          CupertinoSwitch(
                            value: context.read<ThemeCubit>().isDark,
                            onChanged: (value) async {
                              context.read<ThemeCubit>().switchTheme();
                              final prefs = await SharedPreferences.getInstance();
                              prefs.setBool(isDark, value);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



}
