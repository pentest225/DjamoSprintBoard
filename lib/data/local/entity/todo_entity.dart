import '../../../domain/models/todo_entity.dart';

class TodoEntity {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  const TodoEntity({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed
  });

  Todo toTodo(){
        return Todo(userID: userId, id: id, text: title, isComplete: completed);
  }



  static const tableName = "ToDoTable";
}