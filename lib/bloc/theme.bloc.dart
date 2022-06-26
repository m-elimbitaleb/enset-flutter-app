// Event

import 'package:enset_app/ui/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ThemeEvent {}

class SwitchThemeEvent extends ThemeEvent {}

// State

abstract class ThemeState {
  ThemeData themeData;

  ThemeState({required this.themeData});
}

class ThemeSwitchState extends ThemeState {
  ThemeSwitchState({required super.themeData});
}

class InitialThemeState extends ThemeState {
  InitialThemeState() : super(themeData: CustomThemes.themes[0]);
}

// Bloc

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  int currentThemeIndex = 0;

  ThemeBloc() : super(InitialThemeState()) {
    on((SwitchThemeEvent event, emit) {
      currentThemeIndex = currentThemeIndex == CustomThemes.themes.length - 1
          ? 0
          : currentThemeIndex + 1;
      emit(ThemeSwitchState(themeData: CustomThemes.themes[currentThemeIndex]));
    });
  }
}
