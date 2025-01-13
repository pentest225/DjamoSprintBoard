import 'package:dartz/dartz.dart';
import 'package:djamosprintboard/domain/models/todo_entity.dart';
import 'package:djamosprintboard/domain/repositories/todo_repository.dart';
import 'package:djamosprintboard/domain/usecases/get_todo_by_id_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main(){
  GetToDoByIdUseCase usecase;
  MockTodoRepository repository;
  setUp((){
    repository = MockTodoRepository();
    usecase = GetToDoByIdUseCase(repository);
  });

  const mockItem = Todo(userID: 1, id: 1, text: "Text ", isComplete: false);

  // test('should get todo by id from repository', () async {
  //   when(repository.getTodosById(mockItem.id))
  //       .thenAnswer((_) async => const Right(mockItem));
  //
  //   final result = await usecase(mockItem.id);
  //   expect(result, equals(const Right(mockItem)));
  //   verify(repository.getTodosById(mockItem.id));
  //   verifyNoMoreInteractions(repository);
  // });
}


