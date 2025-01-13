import '../../../domain/models/todo_entity.dart';

class TodoDto {
  final int? userId;
  final int? id;
  final String? title;
  final bool? completed;

  // Constructor
  TodoDto({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  factory TodoDto.fromJson(Map<String, dynamic> json) {
    return TodoDto(
      userId: json['userId'] as int?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      completed: json['completed'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'completed': completed,
    };
  }

  Todo toEntity(){
    return Todo(userID: userId ?? -1, id: id ?? -1, text: title?? "", isComplete: completed ?? false);
  }
}
