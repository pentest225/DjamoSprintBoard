import 'package:dartz/dartz.dart';
import 'package:djamosprintboard/core/error/failures.dart';
import '../models/todo_entity.dart';
import '../repositories/todo_repository.dart';

class DeleteTodoUsecase {
  final TodoRepository repository;
  DeleteTodoUsecase(this.repository);
  Future<Either<Failure,bool>> call(int item){
    return repository.deleteTodo(item);
  }
}