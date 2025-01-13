import 'package:djamosprintboard/main.dart';
import 'package:djamosprintboard/presentation/bloc/todo_bloc.dart';
import 'package:djamosprintboard/presentation/pages/todo_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/todo_entity.dart';

class TaskCard extends StatelessWidget {
  final Todo task;

  const TaskCard({super.key,required this.task});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        context.read<TodoBloc>().add(OnSelectTask(task));
        pushWithAnimation(context, TodoDetailScreen(todo: task));
      },
      child: Container(
        padding: const EdgeInsets.only(top:10,bottom: 10,right: 16),
        margin: const EdgeInsets.only(top:5),
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(value: task.isComplete, onChanged: (value){
              if(value != null){
                  final updateTask = Todo(userID: task.userID, id: task.id, text: task.text, isComplete: value);
                  context.read<TodoBloc>().add(OnUpdateTask(updateTask));
              }
            }),
            Expanded(
                child: Text(task.text,
                    style:
                    TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        decoration: task.isComplete ? TextDecoration.lineThrough : TextDecoration.none,
                        color: task.isComplete ? Colors.grey : Colors.black
                    ),maxLines: 2)
            )
          ],),
      ),
    );
  }
}
