import 'package:dartz/dartz.dart';
import 'package:djamosprintboard/core/error/failures.dart';
import '../models/todo_entity.dart';

abstract class TodoRepository {
    Future<Either<Failure,List<Todo>>> getTodos();
    Future<Either<Failure,Todo>> getTodosById(int id);
    Future<Either<Failure,bool>> addTodosById(Todo item);
    Future<Either<Failure,Todo>> updateTodo(Todo item);
    Future<Either<Failure,bool>> deleteTodo(int id);
}