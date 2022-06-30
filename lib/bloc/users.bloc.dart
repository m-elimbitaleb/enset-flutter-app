import 'package:enset_app/model/user.model.dart';
import 'package:enset_app/repository/users.repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Event

abstract class UsersEvent {}

class NextPageEvent extends SearchUsersEvent {
  NextPageEvent(
      {required super.keyword, required super.page, required super.pageSize});
}

class SearchUsersEvent extends UsersEvent {
  final String keyword;
  final int page;
  final int pageSize;

  SearchUsersEvent(
      {required this.keyword, required this.page, required this.pageSize});
}
// State

abstract class UsersState {
  final String currentKeyword;
  final UsersList users;
  final int pageSize;
  final int currentPage;
  final int totalPages;

  UsersState(
      {required this.users,
      required this.currentKeyword,
      required this.currentPage,
      required this.pageSize,
      required this.totalPages});
}

class SearchUsersSuccessState extends UsersState {
  SearchUsersSuccessState(
      {required super.users,
      required super.currentKeyword,
      required super.currentPage,
      required super.pageSize,
      required super.totalPages});
}

class SearchUsersLoadingState extends UsersState {
  SearchUsersLoadingState(
      {required super.users,
      required super.currentKeyword,
      required super.currentPage,
      required super.pageSize,
      required super.totalPages});
}

class SearchUsersErrorState extends UsersState {
  final String errorMessage;

  SearchUsersErrorState(
      {required this.errorMessage,
      required super.users,
      required super.currentKeyword,
      required super.currentPage,
      required super.pageSize,
      required super.totalPages});
}

class UsersInitialState extends UsersState {
  UsersInitialState()
      : super(
            users:
                UsersList(totalCount: 0, incompleteResults: false, users: []),
            currentPage: 0,
            currentKeyword: "",
            pageSize: 20,
            totalPages: 0);
}

// Bloc

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  late UsersEvent currentEvent;

  UsersBloc() : super(UsersInitialState()) {
    on((NextPageEvent event, emit) async {
      currentEvent = event;
      print("Next page ${event.page}");
      emit(SearchUsersLoadingState(
          users: state.users,
          currentKeyword: state.currentKeyword,
          currentPage: state.currentPage,
          pageSize: state.pageSize,
          totalPages: state.totalPages));

      UsersRepository repository = UsersRepository();
      try {
        String keyword = event.keyword;
        UsersList nextPage =
            await repository.searchUsers(keyword, event.page, event.pageSize);
        int totalPages =
        ((nextPage.totalCount + event.pageSize - 1) / event.pageSize).floor();

        if(event.page > totalPages) {
          throw Exception("No more pages");
        }
        var result = state.users;
        result.users.addAll(nextPage.users);
        emit(SearchUsersSuccessState(
            users: result,
            currentPage: event.page,
            pageSize: event.pageSize,
            currentKeyword: event.keyword,
            totalPages: totalPages));
      } catch (exception) {
        emit(SearchUsersErrorState(
            errorMessage: "Unable to fetch users",
            users: state.users,
            currentKeyword: state.currentKeyword,
            currentPage: state.currentPage,
            pageSize: state.pageSize,
            totalPages: state.totalPages));
      }
    });
    on((SearchUsersEvent event, emit) async {
      currentEvent = event;
      print("Searching users");
      emit(SearchUsersLoadingState(
          users: state.users,
          currentKeyword: state.currentKeyword,
          currentPage: state.currentPage,
          pageSize: state.pageSize,
          totalPages: state.totalPages));

      UsersRepository repository = UsersRepository();
      try {
        String keyword = event.keyword;
        UsersList users = await repository.searchUsers(keyword, 0, 20);
        int totalPages =
            ((users.totalCount + event.pageSize - 1) / event.pageSize).floor();

        if(event.page > totalPages) {
          throw Exception("No more pages");
        }
        emit(SearchUsersSuccessState(
            users: users,
            currentPage: state.currentPage,
            pageSize: event.pageSize,
            currentKeyword: event.keyword,
            totalPages: totalPages));
      } catch (exception) {
        emit(SearchUsersErrorState(
            errorMessage: "Unable to fetch users",
            users: state.users,
            currentKeyword: state.currentKeyword,
            currentPage: state.currentPage,
            pageSize: state.pageSize,
            totalPages: state.totalPages));
      }
    });
  }
}
