import 'package:flutter/material.dart';
import 'package:todobloc/bloc/todos/todo_bloc.dart';
import 'package:todobloc/bloc/todos/todo_event.dart';
import 'package:todobloc/bloc/todos/todo_state.dart';
import 'package:todobloc/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerTask = TextEditingController();
    TextEditingController controllerDescription = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('BloC Pattern: Add a To Do'),
      ),
      body:  BlocListener<TodoBloc, TodoState>(

        listener: (context, state) {
          if (state is TodosLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(

                const SnackBar(content: Text("Todo added"))
            );
          }
        },

        child:  SingleChildScrollView(
          child: Card(

            child: Padding(
                padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  _inputField('ID', controllerId),
                  _inputField('Task', controllerTask),
                  _inputField('Description', controllerDescription),

                  ElevatedButton(
                      onPressed: (){
                        var todo = Todo(
                            id: controllerId.value.text,
                            task: controllerTask.value.text,
                            description: controllerDescription.value.text);

                        context.read<TodoBloc>().add(
                          AddTodo(todo: todo)
                        );


                      },
                      child: const Text("add Todo")
                  )
                ],
              ),

            ),
          ),
        )


      ) ,
    );


  }

  Column _inputField(String field, TextEditingController controller,) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$field: ',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          child: TextFormField(
            controller: controller,
          ),
        ),
      ],
    );
  }




}
