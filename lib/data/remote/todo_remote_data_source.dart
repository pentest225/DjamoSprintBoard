import 'package:dio/dio.dart';
import 'package:djamosprintboard/data/remote/dto/todo_dao.dart';
import '../../core/constants.dart';


abstract class TodoRemoteDataSource {
  Future<List<TodoDto>> getTodos();
  Future<TodoDto?> getTodosById(int id);
  Future<bool> addTodosBy(TodoDto item);
  Future<TodoDto> updateTodo(TodoDto item);
  Future<bool> deleteTodo(int id);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {

  // Set default configs
   var dio = Dio(
       BaseOptions(
           baseUrl: Constants.baseUrl,
           connectTimeout: const Duration(milliseconds: Constants.connectTimeout),
           receiveTimeout: const Duration(milliseconds: Constants.receiveTimeOut),
           contentType: "application/json",
           headers: {
             "Accept": "application/json",
             "Content-Type": "application/json",
             "Accept-Language": "fr",
           })
   );



  @override
  Future<bool> addTodosBy(TodoDto item) async {
    try {
      const url = "${Constants.baseUrl}/todos";
      final response = await dio.post(url,data:item.toJson());
      if(response.statusCode == 201){
        return true;
      } else {
        //TODO: gerer les exceptions
        return false;
      }
    } catch(_) {
        //TODO: gerer les exceptions
        return false;
    }
  }

  @override
  Future<bool> deleteTodo(int id) async {
    try {
      final url = "${Constants.baseUrl}/$id";
      final response = await dio.delete(url);
      if(response.statusCode == 200){
        return true;
      } else {
        //TODO: gerer les exceptions
        return false;
      }
    } catch(_) {
      //TODO: gerer les exceptions
      return false;
    }
  }

  @override
  Future<List<TodoDto>> getTodos() async {
    try {
      const url = "${Constants.baseUrl}/todos?userId=${Constants.userId}";
      final response = await dio.get(url);
      if(response.statusCode == 200){
        final data = response.data as List;
        final items = data.map((e)=> TodoDto.fromJson(e)).toList();
        return items;
      } else {
        //TODO: gerer les exceptions
        return [];
      }
    } catch(_) {
      //TODO: gerer les exceptions
      return [];
    }
  }

  @override
  Future<TodoDto?> getTodosById(int id) async {
    try {
      final url = "${Constants.baseUrl}/todos/$id";
      final response = await dio.get(url);
      if(response.statusCode == 200){
        final data = response.data as Map<String,dynamic>;
        final item = TodoDto.fromJson(data);
        return item;
      } else {
        //TODO: gerer les exceptions
        return null ;
      }
    } catch(_) {
      //TODO: gerer les exceptions
      return null;
    }
  }

  @override
  Future<TodoDto> updateTodo(TodoDto item) async {
    try {
      final url = "${Constants.baseUrl}/todos/${item.id}";
      final response = await dio.post(url,data:item.toJson());
      if(response.statusCode == 200){
        final data = response.data as Map<String,dynamic>;
        final item = TodoDto.fromJson(data);
        return item;

      } else {
        //TODO: gerer les exceptions
        return item;
      }
    } catch(_) {
      //TODO: gerer les exceptions
      return item;
    }
  }

}