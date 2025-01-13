import 'package:djamosprintboard/data/local/entity/todo_entity.dart';
import 'package:djamosprintboard/domain/models/todo_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoEntity>> getTodos();
  Future<TodoEntity?> getTodosById(int id);
  Future<void> insert(List<Todo> items);
  Future<TodoEntity> updateTodosBy(Todo item);
  Future<void> deleteTodo(int id);
}


class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  late Database _database;
  Future<void> _initDataBase() async {
     _database = await openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE ${TodoEntity.tableName}(id INTEGER PRIMARY KEY,userId INTEGER,text TEXT, completed INTEGER)',
        );
      },
      version: 1,
    );
  }


  @override
  Future<List<TodoEntity>> getTodos() async {
    await _initDataBase();
    final List<Map<String,dynamic>> items = await _database.query(TodoEntity.tableName);
    final result = [
      for (final {
        'id': id as int,
        'userId': userId as int,
        'text': title as String,
        'completed': isComplete as int,
      } in items)
        TodoEntity(userId: userId, id: id, title: title, completed: isComplete == 1 ? true: false)
    ];
    print("Get ToDo List ${result}");
    return result;
  }

  @override
  Future<TodoEntity?> getTodosById(int id) async {
    await _initDataBase();
    final result = await _database.query(TodoEntity.tableName,where: 'id = ?',whereArgs: [id]);
    if(result.isEmpty){
      return null;
    } else {
      final userId = result.first['userId'] as int;
      final title = result.first['title'] as String;
      final isComplete = result.first['userId'] as int;
      return TodoEntity(userId: userId, id: id, title: title, completed: isComplete == 1 ? true : false);
    }

  }



  @override
  Future insert(List<Todo> items) async {
    await _initDataBase();
    for (var item in items) {
      _database.insert(TodoEntity.tableName, item.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<TodoEntity> updateTodosBy(Todo item) async {
    await _initDataBase();
    final id = await _database.update(TodoEntity.tableName, item.toMap(),where: 'id = ?', whereArgs: [item.id]);
    return TodoEntity(userId: item.userID, id: id, title: item.text, completed: item.isComplete);
  }

  @override
  Future<void> deleteTodo(int id) async {
    await _initDataBase();
    _database.delete(TodoEntity.tableName,where: 'id = ?', whereArgs: [id]);

  }
  
}