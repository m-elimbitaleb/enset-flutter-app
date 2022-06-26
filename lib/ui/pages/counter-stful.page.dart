import 'package:enset_app/ui/widgets/main-drawer.widget.dart';
import 'package:flutter/material.dart';

class CounterStatefullPage extends StatefulWidget {
  const CounterStatefullPage({Key? key}) : super(key: key);

  @override
  State<CounterStatefullPage> createState() => _CounterStatefullPageState();
}

class _CounterStatefullPageState extends State<CounterStatefullPage> {
  int counter = 0;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Stateful"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$counter", style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 20),
          Text(errorMessage, style: Theme.of(context).textTheme.caption)
        ],
      )),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "dec",
            onPressed: () {
              setState(() {
                if (counter > 0) {
                  counter--;
                  if (errorMessage != "") errorMessage = "";
                } else {
                  errorMessage = "Counter value can not be less than 0";
                }
              });
            },
            child: Icon(Icons.remove),
          ),
          const SizedBox(
            width: 5,
          ),
          FloatingActionButton(
            heroTag: "inc",
            onPressed: () {
              setState(() {
                if (counter < 10) {
                  counter++;
                  if (errorMessage != "") errorMessage = "";
                } else {
                  errorMessage = "Counter value can not exceed 10";
                }
              });
            },
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
