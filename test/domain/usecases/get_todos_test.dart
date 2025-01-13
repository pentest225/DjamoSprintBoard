import 'package:dartz/dartz.dart';
import 'package:djamosprintboard/domain/models/todo_entity.dart';
import 'package:djamosprintboard/domain/repositories/todo_repository.dart';
import 'package:djamosprintboard/domain/usecases/get_todos_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockTodoRepository extends Mock implements TodoRepository {}


void main(){
  late GetTodosUseCase usecase;
  late MockTodoRepository repository;
  setUp((){
    repository = MockTodoRepository();
    usecase = GetTodosUseCase(repository);
  });

  final mockTodosList =  [const Todo(userID: 1, id: 1, text: "Test 1", isComplete: false)];

  // test('should get toto list from repository ', () async {
  //   when(repository.getTodos())
  //       .thenAnswer((_) async => Right(mockTodosList));
  //
  //   final result = await usecase();
  //
  //   expect(result, equals(Right(mockTodosList)));
  //   verify(repository.getTodos());
  //   verifyNoMoreInteractions(repository);
  // });
}