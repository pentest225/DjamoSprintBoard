
import 'package:dartz/dartz.dart';
import 'package:djamosprintboard/core/error/failures.dart';
import 'package:djamosprintboard/domain/models/todo_entity.dart';
import 'package:djamosprintboard/domain/repositories/todo_repository.dart';


class GetTodosUseCase {
  final TodoRepository repository;
  GetTodosUseCase(this.repository);

  Future<Either<Failure, List<Todo>>> call() {
    return repository.getTodos();
  }
}

