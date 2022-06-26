import 'package:enset_app/bloc/counter.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBlocPage extends StatelessWidget {
  const CounterBlocPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Bloc"),
      ),
      body: Center(child:
          BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
        if (state is CounterErrorState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${state.counter}",
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 20),
              Text(state.errorMessage,
                  style: Theme.of(context).textTheme.caption)
            ],
          );
        } else {
          return Text("${state.counter}",
              style: Theme.of(context).textTheme.headlineLarge);
        }
      })),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "dec",
            onPressed: () {
              context.read<CounterBloc>().add(DecrementCounterEvent());
            },
            child: Icon(Icons.remove),
          ),
          const SizedBox(
            width: 5,
          ),
          FloatingActionButton(
            heroTag: "inc",
            onPressed: () {
              context.read<CounterBloc>().add(IncrementCounterEvent());
            },
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
