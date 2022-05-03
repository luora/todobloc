
import 'package:flutter/material.dart';
import 'package:todobloc/bloc/todos/todo_bloc.dart';
import 'package:todobloc/bloc/todos/todo_event.dart';
import 'package:todobloc/bloc/todos/todo_state.dart';
import 'package:todobloc/bloc/todosfilter/todo_filter_bloc.dart';
import 'package:todobloc/bloc/todosfilter/todo_filter_event.dart';
import 'package:todobloc/bloc/todosfilter/todo_filter_model.dart';
import 'package:todobloc/bloc/todosfilter/todo_filter_state.dart';
import 'package:todobloc/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      
      child: Scaffold(
        
        appBar: AppBar(
          title: const Text("Bloc pattern"),

          actions: [
            IconButton(
                onPressed: (){
                  Navigator.push(
                      context,
                    MaterialPageRoute(builder: (_)=>const AddTodoScreen())
                      );
                },
                icon: const Icon(Icons.add))
          ],
          
          bottom: TabBar(
            onTap: (tabIndex){

              switch (tabIndex){
                case 0:
                  BlocProvider.of<TodosFilterBloc>(context)
                      .add(const UpdateTodos(
                    todosFilter: TodosFilter.pending
                  ));
                  break;
                
                case 1:
                  BlocProvider.of<TodosFilterBloc>(context)
                      .add(
                    const UpdateTodos(
                      todosFilter: TodosFilter.completed
                    )
                  );
                  break;

              }

            },
              tabs: const [
                Tab(
                  icon: Icon(Icons.pending),
                ),
                Tab(
                  icon: Icon(Icons.add_task),
                )
              ],
          ),


        ),
        body: TabBarView(
            children: [
              _toDos("pending todos"),

              _toDos("completed todos"),
            ]
        )
        

      ),
    );
  }

  BlocBuilder<TodosFilterBloc, TodosFilterState> _toDos(String title) {
    return BlocBuilder<TodosFilterBloc, TodosFilterState>(
      builder: (context, state) {

        print("what state");

        print(state);

        if(state is TodosFilterLoading){

          return const Center(
            child: CircularProgressIndicator(
              color: Colors.grey,
            ),
          );
        }
        else if(state is TodosFilterLoaded){

          if(state.filtered.isEmpty) {
            return const Center(
              child: Text("list is empty"),
            );
          }

         return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Container(
                  padding: const EdgeInsets.all(8),

                  child:  Text(title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.filtered.length,
                    itemBuilder: (context, index){
                      return _todoCard(state.filtered[index]);
                    })

              ],
            ),

          );

        }else {
          return const Center(child: Text("something went wrong"));
        }

        return const Center(child: Text("something went wrong"));


      },

    );
  }

  Card _todoCard(Todo todo){
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
          padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text(
              '#${todo.id}: ${todo.task}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),


            ),

            Row(
              children: [
                IconButton(
                    onPressed: (){
                      context.read<TodoBloc>().add(
                        UpdateTodo(
                            todo: todo.copyWith(isCompleted: true))
                      );
                    },
                    icon: const Icon(Icons.add_task_sharp)
                ),
                IconButton(
                    onPressed: (){
                      context.read<TodoBloc>().add(
                        DeleteTodo(todo: todo)
                      );
                    },
                    icon: const Icon(Icons.cancel)
                ),
              ],
            )
          ],


        ),
      ),
    );
  }
}
