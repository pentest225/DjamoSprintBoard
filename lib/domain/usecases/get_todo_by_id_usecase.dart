
import 'package:dartz/dartz.dart';
import 'package:djamosprintboard/core/error/failures.dart';
import 'package:djamosprintboard/domain/models/todo_entity.dart';
import 'package:djamosprintboard/domain/repositories/todo_repository.dart';


class GetToDoByIdUseCase {
  final TodoRepository repository;
  GetToDoByIdUseCase(this.repository);

  Future<Either<Failure,Todo>> call(int id)  {
    return repository.getTodosById(id);
  }
}