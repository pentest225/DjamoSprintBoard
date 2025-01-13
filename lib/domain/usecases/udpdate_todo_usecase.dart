import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../models/todo_entity.dart';
import '../repositories/todo_repository.dart';

class UpdateTodoUsecase {
  final TodoRepository repository;
  UpdateTodoUsecase(this.repository);

  Future<Either<Failure,Todo>> call(Todo item)  {
    return repository.updateTodo(item);
  }
}
