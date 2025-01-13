import 'package:djamosprintboard/core/themes/app_colors.dart';
import 'package:djamosprintboard/presentation/widget/TaskCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/todo_entity.dart';
import '../bloc/todo_bloc.dart';
import '../widget/EmptyTaskCard.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Djamo Spring Boards",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: scaffoldBackgroundColor,
      body: SafeArea(
          child: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {},
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Container(
              padding: const EdgeInsets.all(16),
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller:_controller,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                                fontFamily: "RobotoRegular", fontSize: 16),
                            labelStyle:const TextStyle(fontFamily: "RobotoBold",fontSize: 22,fontWeight: FontWeight.bold),
                            hintText: "Ajouter une tâche",
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: secondaryColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryColor.withOpacity(0.7),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const SizedBox(
                                height: 20, width: 20, child: Icon(Icons.add)),
                          ),
                          keyboardType:TextInputType.text,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (String value){
                            context.read<TodoBloc>().add(OnEditTask(value));
                            _controller.clear();
                          },
                        ),
                      ),
                      Container(height: 20),
                      if(state.todoList.isEmpty)
                        const EmptyTaskCard(),
                      if(state.todoList.isNotEmpty)
                        const Text(
                          "List des tâches",
                          style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                      if(state.todoList.isNotEmpty)
                        Container(height: 10),
                        ..._buildTaskList(state.todoList.where((el) {
                          return el.isComplete == false;
                        }).toList()),
                      if(state.todoList.isNotEmpty)
                        Container(height: 10),
                      if(state.todoList.isNotEmpty)
                        const Text(
                          "Tâches éffectuées",
                          style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                      if(state.todoList.isNotEmpty)
                        ..._buildTaskList(state.todoList.where((el) {
                          return el.isComplete == true;
                        }).toList())

                      //ND: C'est pas forcement une idéal d'avoir autant de IF dans un seul ficheir ;-)
                    ],
                  );
                },
              ),
            )))
          ],
        ),
      )),

    );
  }

  List<Widget> _buildTaskList(List<Todo> tasks) {
    return tasks.map((el) => TaskCard(task: el)).toList();
  }
}
