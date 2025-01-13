import 'package:djamosprintboard/domain/models/todo_entity.dart';
import 'package:djamosprintboard/main.dart';
import 'package:flutter/material.dart';
import 'package:djamosprintboard/core/themes/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';


class TodoDetailScreen extends StatefulWidget {
  Todo todo;
  TodoDetailScreen({super.key,required this.todo});
  @override
  State<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    _controller.text = widget.todo.text;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              "Djamo Spring Boards",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(onPressed: (){
              context.read<TodoBloc>().add(OnDeleteTask(widget.todo.id));
              pop(context);
            }, icon: const Icon(Icons.delete_forever_outlined))
          ],
        ),
        centerTitle: true,
        leading:  IconButton(onPressed: (){
          pop(context);
        }, icon: const Icon(Icons.arrow_back)),
      ),
      backgroundColor: scaffoldBackgroundColor,
      body: SafeArea(
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
                                      prefixIcon:  SizedBox(
                                          height: 20, width: 20,
                                          child: Checkbox(value: widget.todo.isComplete, onChanged: (value){
                                            if(value != null){
                                              final updateTask = Todo(userID: widget.todo.userID, id: widget.todo.id, text: widget.todo.text, isComplete: value);
                                              context.read<TodoBloc>().add(OnUpdateTask(updateTask));
                                            }
                                          })),
                                    ),
                                    keyboardType:TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (String value){
                                      final current = state.selectedTask!!;
                                      final updateTask = Todo(userID: current.userID, id: current.id, text: value, isComplete: current.isComplete);
                                      context.read<TodoBloc>().add(OnUpdateTask(updateTask));
                                      _controller.clear();
                                      pop(context);
                                    },
                                    maxLines: 5,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )))
            ],
          )),

    );
  }
}
