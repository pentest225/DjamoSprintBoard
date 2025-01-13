import 'package:dartz/dartz.dart';
import 'package:djamosprintboard/core/error/exceptions.dart';
import 'package:djamosprintboard/core/error/failures.dart';
import 'package:djamosprintboard/core/network/network_info.dart';
import 'package:djamosprintboard/data/remote/dto/todo_dao.dart';
import 'package:djamosprintboard/domain/repositories/todo_repository.dart';
import '../../domain/models/todo_entity.dart';
import '../local/todo_local_datasource.dart';
import '../remote/todo_remote_data_source.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;
  final TodoLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TodoRepositoryImpl(
      { required this.remoteDataSource,required this.localDataSource,required this.networkInfo});

  @override
  Future<Either<Failure, bool>> addTodosById(Todo item) async {
    if(await networkInfo.isConnected){
        try {
          await remoteDataSource.addTodosBy(TodoDto(userId: item.userID,id:item.id,title: item.text,completed: item.isComplete));
          await localDataSource.insert([item]);
          return const Right(true);
        } catch (_) {
            return Left(ServerFailure());
        }
    } else {
        try {
          await localDataSource.insert([item]);
          return const Right(true);
        } catch (_) {
          return Left(CacheFailure());
        }
    }
  }


  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    if(await networkInfo.isConnected){
        try {
          final remoteTodoList = await remoteDataSource.getTodos();

          final List<Todo> itemList  = [];
          for (var el in remoteTodoList) {
            itemList.add(el.toEntity());
          }
          localDataSource.insert(itemList);
          return Right(itemList);
        } on ServerException {
          return Left(ServerFailure());
        }
    } else {
        try {
          final localTodoList = await localDataSource.getTodos();
          final List<Todo> itemList  = [];
          for (var el in localTodoList) {
            itemList.add(el.toTodo());
          }
          return Right(itemList);
        } on CacheException {
          return Left(CacheFailure());
        }
    }

  }

  @override
  Future<Either<Failure, Todo>> getTodosById(int id) async {
    if(await networkInfo.isConnected){
        final item = await remoteDataSource.getTodosById(id);
        if(item != null){
          return Right(item.toEntity());
        } else {
          return Left(ServerFailure());
        }
    } else {
      final item = await localDataSource.getTodosById(id);
      if(item != null){
        return Right(item.toTodo());
      } else {
        return Left(CacheFailure());
      }
    }
  }


  @override
  Future<Either<Failure, Todo>> updateTodo(Todo item) async {
    if(await networkInfo.isConnected){
      try {
        final response = await remoteDataSource.updateTodo(TodoDto(userId: item.userID,id: item.id,completed: item.isComplete));
        localDataSource.updateTodosBy(item);
        return Right(response.toEntity());
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final response = await localDataSource.updateTodosBy(item);
        return Right(response.toTodo());
      } catch (_) {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTodo(int id) async {
    if(await networkInfo.isConnected){
      try {
        final response = await remoteDataSource.deleteTodo(id);
        if(response){
          await localDataSource.deleteTodo(id);
          return const Right(true);
        } else {
          return Left(CacheFailure());
        }
      } catch (_){
        return Left(ServerFailure());
      }
    } else {
      try {
        await localDataSource.deleteTodo(id);
        return const Right(true);
      } catch(_) {
        return Left(CacheFailure());
      }
    }
  }
  
}
