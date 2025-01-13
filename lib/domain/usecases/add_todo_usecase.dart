import 'package:dartz/dartz.dart';
import 'package:djamosprintboard/core/error/failures.dart';
import 'package:djamosprintboard/domain/repositories/todo_repository.dart';

import '../models/todo_entity.dart';

class AddTodoUseCase {
  final TodoRepository repository;
  AddTodoUseCase(this.repository);

  Future<Either<Failure,bool>> call(Todo item) async {
       return repository.addTodosById(item);
  }
}