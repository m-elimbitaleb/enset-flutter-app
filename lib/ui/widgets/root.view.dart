import 'package:enset_app/bloc/theme.bloc.dart';
import 'package:enset_app/ui/pages/counter-bloc.page.dart';
import 'package:enset_app/ui/pages/counter-stful.page.dart';
import 'package:enset_app/ui/pages/git-users.page.dart';
import 'package:enset_app/ui/pages/home.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootView extends StatelessWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return MaterialApp(
        theme: state.themeData,
        routes: {
          "/": (context) => const HomePage(),
          "/counter-stful": (context) => const CounterStatefullPage(),
          "/counter-bloc": (context) => const CounterBlocPage(),
          "/git-users": (context) => const GitUsersPage(),
        },
      );
    });
  }
}
