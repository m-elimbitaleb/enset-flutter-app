import 'package:enset_app/ui/widgets/main-drawer.widget.dart';
import 'package:flutter/material.dart';

class GitUsersPage extends StatelessWidget {
  const GitUsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Git users page"),
      ),
      body: const Center(
        child: Text("Git users Page"),
      ),
    );
  }
}
