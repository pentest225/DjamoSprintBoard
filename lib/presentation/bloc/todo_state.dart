part of 'todo_bloc.dart';

final class TodoState extends Equatable {
  final List<Todo> todoList;
  final Todo? selectedTask;
  final bool isLoading;
  final String? errorMessage;

  const TodoState({
    this.todoList = const [],
    this.selectedTask,
    this.isLoading = false,
    this.errorMessage,
  });

  TodoState copyWith({
    List<Todo>? todoList,
    Todo? selectedTask,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TodoState(
      todoList: todoList ?? this.todoList,
      selectedTask: selectedTask ?? this.selectedTask,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [todoList, selectedTask, isLoading, errorMessage];
}

// final class TodoInitial extends TodoState {
//   @override
//   List<Object> get props => [];
// }


// part of 'home_bloc_bloc.dart';
//
// final class HomeState extends Equatable {
//   final User user;
//   final String userBallance;
//   final bool userBallanceIsLoading;
//   final bool transactionHistoryIsLoading;
//   final List<XikkaTransaction> transactions;
//
//   final bool showAccountBallance;
//   final String currency;
//
//   const HomeState({
//     this.user = User.emptyUser,
//     this.showAccountBallance = true,
//     this.userBallance = "00",
//     this.userBallanceIsLoading = false,
//     this.transactionHistoryIsLoading = false,
//     this.transactions = const <XikkaTransaction>[],
//     this.currency = Constants.currency
//   });
//
//   @override
//   List<Object> get props => [
//     user,
//     userBallance,
//     userBallanceIsLoading,
//     transactionHistoryIsLoading,
//     transactions,
//     showAccountBallance,
//     currency
//   ];
//
//   HomeState copyWith(
//       {User? user,
//         String? userBallance,
//         bool? userBallanceIsLoading,
//         bool? transactionHistoryIsLoading,
//         List<XikkaTransaction>? transactions,
//         bool? showAccountBallance,
//         String? currency,
//       }) {
//     return HomeState(
//         user: user ?? this.user,
//         showAccountBallance: showAccountBallance ?? this.showAccountBallance,
//         userBallanceIsLoading:
//         userBallanceIsLoading ?? this.userBallanceIsLoading,
//         transactionHistoryIsLoading:
//         transactionHistoryIsLoading ?? this.transactionHistoryIsLoading,
//         transactions: transactions ?? this.transactions,
//         userBallance: userBallance ?? this.userBallance,
//         currency: currency ?? this.currency
//     );
//   }
// }
