import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int userID;
  final int id;
  final String text;
  final bool isComplete;

  const Todo({
    required this.userID,
    required this.id,
    required this.text,
    required this.isComplete,
});

  @override
  List<Object?> get props => [userID,id,text,isComplete];

  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'userId':userID,
      'text':text,
      'completed': isComplete ? 1 : 0
    };
  }
}