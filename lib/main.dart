import 'package:flutter/material.dart';
import 'package:todobloc/bloc/todos/todo_bloc.dart';
import 'package:todobloc/bloc/todos/todo_event.dart';
import 'package:todobloc/bloc/todos/todo_state.dart';
import 'package:todobloc/bloc/todosfilter/todo_filter_bloc.dart';
import 'package:todobloc/screens/homescreen.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(
          create: (BuildContext context) {
            TodoBloc todobloc = TodoBloc();

            List<Todo> todos = [
              Todo(id: '1', task: "simple Todo 1", description: "Test todo 1"),
              Todo(id: '2', task: "simple Todo 2" , description: "Test todo 2"),
            ];

            todobloc.add(const LoadTodos());
            return todobloc;
          },


        ),

        BlocProvider<TodosFilterBloc>(
          create: (BuildContext context) {
            
            return TodosFilterBloc(
                todoBloc: BlocProvider.of<TodoBloc>(context)
            );
          },

        )

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF000A1F),
          appBarTheme: const AppBarTheme(
            color: Color(0xFF000A1F),
          )
        ),
        home: const HomeScreen()
      ),
    );
  }
}

