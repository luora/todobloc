 import 'package:bloc/bloc.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todobloc/bloc/todos/todo_event.dart';
import 'package:todobloc/bloc/todos/todo_state.dart';

import '../../models/todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState>{
  TodoBloc() : super(TodosLoading())
  {

    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<UpdateTodo>(_onUpdateTodo);
  }


  void _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {

    await Future.delayed(const Duration(seconds: 3));

    emit(
      TodosLoaded(todos: event.todos)
    );
  }

  void _onAddTodo(AddTodo event, Emitter<TodoState> emit){

    print("add to do");

    final state = this.state;




    print("current state $state");
    if(state is TodosLoaded){
      print("add");



      List<Todo> todos = [
        Todo(id: '1', task: "simple Todo 1", description: "Test todo 1"),
        Todo(id: '2', task: "simple Todo 2" , description: "Test todo 2"),
      ];

      // state.todos.addAll(todos);

      emit(
        state.copyWith(
            todos: List.from(state.todos)..add(event.todo)
        )
      );
    }
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit){

    final todo = event.todo;

    final state = this.state;

    if(state is TodosLoaded){

      List<Todo> todos  = state.todos;

      emit(
        state.copyWith(
          todos: List.from(state.todos)..remove(todo)
        )
      );
    }
  }

  void _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit){

    final state = this.state;

    if(state is TodosLoaded){

      List<Todo> todos = (
        state.todos.map((todo) {
          return todo.id == event.todo.id ? event.todo : todo;
        })
      ).toList();

      emit(
        state.copyWith(todos: todos)
      );
    }

  }

}