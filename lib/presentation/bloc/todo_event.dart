part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();
  @override
  List<Object?> get props => [];
}
final class OnGetTodoList extends TodoEvent {}

final class OnEditTask extends TodoEvent {
  final String task;
  const OnEditTask(this.task);
  @override
  List<Object?> get props => [task];
}

final class OnSelectTask extends TodoEvent {
  final Todo task;
  const OnSelectTask(this.task);

  @override
  List<Object?> get props => [task];
}

final class OnAddTask extends TodoEvent {
  final Todo task;
  const OnAddTask(this.task);

  @override
  List<Object?> get props => [task];
}

final class OnUpdateTask extends TodoEvent {
  final Todo task;
  const OnUpdateTask(this.task);

  @override
  List<Object?> get props => [task];
}

final class OnDeleteTask extends TodoEvent {
  final int taskId;
  const OnDeleteTask(this.taskId);
  @override
  List<Object?> get props => [taskId];
}

