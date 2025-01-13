import 'dart:async';

import 'package:djamosprintboard/core/constants.dart';
import 'package:djamosprintboard/domain/usecases/add_todo_usecase.dart';
import 'package:djamosprintboard/domain/usecases/delete_todo_usecase.dart';
import 'package:djamosprintboard/domain/usecases/get_todo_by_id_usecase.dart';
import 'package:djamosprintboard/domain/usecases/get_todos_usecase.dart';
import 'package:djamosprintboard/domain/usecases/udpdate_todo_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/models/todo_entity.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final AddTodoUseCase addTodoUseCase;
  final GetTodosUseCase getTodosUseCase;
  final UpdateTodoUsecase updateTodoUsecase;
  final GetToDoByIdUseCase getToDoByIdUseCase;
  final DeleteTodoUsecase deleteTodoUsecase;

  TodoBloc(this.getTodosUseCase,this.getToDoByIdUseCase,this.updateTodoUsecase,this.deleteTodoUsecase,this.addTodoUseCase) : super(const TodoState()) {
    on<OnGetTodoList>(_onGetTodoList);
    on<OnAddTask>(_onAddTask);
    on<OnUpdateTask>(_onUpdateTask);
    on<OnDeleteTask>(_onDeleteTask);
    on<OnEditTask>(_onEditTask);
    on<OnSelectTask>(_onSelectTask);
  }


  Future<void> _onGetTodoList(OnGetTodoList event,Emitter emit) async {
    final response = await getTodosUseCase();
    response.fold(
      (failure) => {
        emit(state.copyWith(errorMessage: "Error to get todo list"))
      },
      (success) => {
        emit(state.copyWith(todoList: success))

      }
    );
  }

  Future<void> _onAddTask(OnAddTask event, Emitter emit) async {

  }



  FutureOr<void> _onUpdateTask(OnUpdateTask event, Emitter<TodoState> emit)async {
      final response = await updateTodoUsecase(event.task);
      response.fold((failure)=> {
        emit(state.copyWith(errorMessage: "Error to get todo list"))
      },
      (success) => {
        //Refresh the list
        add(OnGetTodoList())
        }
      );
  }

  FutureOr<void> _onDeleteTask(OnDeleteTask event, Emitter<TodoState> emit) async {
    final response = await deleteTodoUsecase(event.taskId);
    response.fold((failure)=> {
      emit(state.copyWith(errorMessage: "Error to get todo list"))
    },
    (success)=> {
          //Refresh the list
          add(OnGetTodoList())
    }
    );
  }

  FutureOr<void> _onEditTask(OnEditTask event, Emitter<TodoState> emit) async {
    final response = await addTodoUseCase(Todo(userID: Constants.userId, id: -1, text: event.task, isComplete: false));
    response.fold((failure)=> {
      emit(state.copyWith(errorMessage: "Error to get todo list"))
    },
     (success)=> {
        //Refresh the list
        add(OnGetTodoList())
     }
    );
  }

  FutureOr<void> _onSelectTask(OnSelectTask event, Emitter<TodoState> emit) {
      emit(state.copyWith(selectedTask: event.task));
  }
}
