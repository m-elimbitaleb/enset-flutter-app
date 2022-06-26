import 'package:enset_app/bloc/counter.bloc.dart';
import 'package:enset_app/bloc/theme.bloc.dart';
import 'package:enset_app/ui/widgets/root.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => CounterBloc()),
      BlocProvider(create: (context) => ThemeBloc()),
    ], child: const RootView());
  }
}
