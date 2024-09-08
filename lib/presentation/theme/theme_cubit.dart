import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/theme/theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit({required this.isDark}) : super(lightTheme) {
    if(isDark) {
      emit(darkTheme);
    }else {
      emit(lightTheme);
    }
  }

  bool isDark;
  
  void switchTheme() {
    if(isDark) {
      emit(lightTheme);
    } else {
      emit(darkTheme);
    }
    isDark = !isDark;
  }
  
}