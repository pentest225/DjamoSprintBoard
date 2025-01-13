import 'package:dio/dio.dart';
import 'package:djamosprintboard/core/network/network_info.dart';
import 'package:djamosprintboard/data/local/todo_local_datasource.dart';
import 'package:djamosprintboard/data/remote/todo_remote_data_source.dart';
import 'package:djamosprintboard/data/repositories/todo_repository_impl.dart';
import 'package:djamosprintboard/domain/repositories/todo_repository.dart';
import 'package:djamosprintboard/domain/usecases/add_todo_usecase.dart';
import 'package:djamosprintboard/domain/usecases/delete_todo_usecase.dart';
import 'package:djamosprintboard/domain/usecases/get_todo_by_id_usecase.dart';
import 'package:djamosprintboard/domain/usecases/get_todos_usecase.dart';
import 'package:djamosprintboard/domain/usecases/udpdate_todo_usecase.dart';
import 'package:djamosprintboard/presentation/bloc/todo_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> initDepInjection() async {
  sl.registerSingleton(Dio());
  //DATA
  sl.registerSingleton<TodoLocalDataSource>(TodoLocalDataSourceImpl());
  sl.registerSingleton<TodoRemoteDataSource>(TodoRemoteDataSourceImpl());
  sl.registerSingleton<NetworkInfo>(NetworkInfoImpl());

  sl.registerSingleton<TodoRepository>(TodoRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  //DOMAIN

  sl.registerSingleton<GetToDoByIdUseCase>(GetToDoByIdUseCase(sl()));
  sl.registerSingleton<DeleteTodoUsecase>(DeleteTodoUsecase(sl()));
  sl.registerSingleton<UpdateTodoUsecase>(UpdateTodoUsecase(sl()));
  sl.registerSingleton<GetTodosUseCase>(GetTodosUseCase(sl()));
  sl.registerSingleton<AddTodoUseCase>(AddTodoUseCase(sl()));
  //PRESENTATION
  sl.registerFactory<TodoBloc>(() => TodoBloc(
      sl(), sl(), sl(),sl(),sl()));


}

