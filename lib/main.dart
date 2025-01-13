import 'package:djamosprintboard/presentation/bloc/todo_bloc.dart';
import 'package:djamosprintboard/presentation/pages/todo_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dep_injection.dart';

pop(BuildContext context, {dynamic returnData}) {
  if (returnData != null) {
    Navigator.of(context).pop(returnData);
  } else {
    Navigator.of(context).pop();
  }
}

popUntil(BuildContext context, String routeName) {
  Navigator.of(context).popUntil((route) => route.isFirst);
}

pushWithAnimation(BuildContext context, Widget screen) {
  Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secAnimation, Widget child) {
        animation =
            CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic);
        return ScaleTransition(
          scale: animation,
          alignment: Alignment.center,
          child: child,
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secAnimation) {
        return screen;
      }));
}


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDepInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<TodoBloc>(create: (BuildContext context) => sl()..add(OnGetTodoList()))
        ],
      child: MaterialApp(
        title: 'Todo List',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TodoListScreen(),
      ),
    );
  }
}

