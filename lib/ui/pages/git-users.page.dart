import 'package:enset_app/bloc/users.bloc.dart';
import 'package:enset_app/ui/pages/git-repositories.page.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class GitUsersPage extends StatefulWidget {
  const GitUsersPage({Key? key}) : super(key: key);

  @override
  State<GitUsersPage> createState() => _GitUsersPageState();
}

class _GitUsersPageState extends State<GitUsersPage> {
  TextEditingController controller =
      TextEditingController(text: "Moulaye");
  int currentPage = 0;
  int pageSize = 20;

  void search() {
    context.read<UsersBloc>().add(SearchUsersEvent(
        keyword: controller.text, page: currentPage, pageSize: pageSize));
  }

  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(SearchUsersEvent(
        keyword: controller.text, page: currentPage, pageSize: pageSize));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
          if (state is SearchUsersSuccessState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Users"),
                Text("${state.currentPage}/${state.totalPages}")
              ],
            );
          } else {
            return (const Text("Users"));
          }
        }),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).primaryColor))),
                )),
                IconButton(
                    onPressed: () {
                      search();
                    },
                    icon: const Icon(Icons.search)),
              ],
            ),
          ),
          BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
            if (state is SearchUsersLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SearchUsersErrorState) {
              return Center(
                  child: Column(children: [
                Text(
                  state.errorMessage,
                  style: Theme.of(context).textTheme.caption,
                ),
                ElevatedButton(
                    onPressed: () {
                      UsersBloc usersBloc = context.read<UsersBloc>();
                      context.read<UsersBloc>().add(usersBloc.currentEvent);
                    },
                    child: const Text("Retry")),
              ]));
            } else if (state is SearchUsersSuccessState) {
              return Expanded(
                  child: LazyLoadScrollView(
                onEndOfPage: () {
                  context.read<UsersBloc>().add(NextPageEvent(
                      keyword: state.currentKeyword,
                      page: state.currentPage + 1,
                      pageSize: state.pageSize));
                },
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      var user = state.users.users[index];
                      return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        GitRepositoriesPage(user: user)));
                          },
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(user.avatarUrl),
                                        radius: 50),
                                    SizedBox(width: 10),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Text(user.login)),
                                  ],
                                ),
                                CircleAvatar(
                                  child: Text("${user.score.floor()}"),
                                ),
                              ]));
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 2,
                      );
                    },
                    itemCount: state.users.users.length),
              ));
            } else {
              return Container();
            }
          }),
        ],
      ),
    );
  }
}
