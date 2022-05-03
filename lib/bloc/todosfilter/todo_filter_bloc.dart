
import 'dart:async';

import 'package:todobloc/bloc/todos/todo_bloc.dart';
import 'package:todobloc/bloc/todos/todo_state.dart';
import 'package:todobloc/bloc/todosfilter/todo_filter_event.dart';
import 'package:todobloc/bloc/todosfilter/todo_filter_model.dart';
import 'package:todobloc/bloc/todosfilter/todo_filter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/todo.dart';

class TodosFilterBloc extends Bloc<TodosFilterEvent, TodosFilterState>{

  final TodoBloc _todoBloc;
  late StreamSubscription _todosSubscription;

  TodosFilterBloc({required TodoBloc todoBloc}):
        _todoBloc = todoBloc,
        super(TodosFilterLoading()){
    
    on<UpdateTodos>(_onUpdateTodos);

    on<UpdateFilter>(_onUpdateFilter);

    _todosSubscription = _todoBloc.stream.listen((state) {
      add(
          const UpdateFilter()
      );
    });

  }

  void _onUpdateFilter(UpdateFilter event, Emitter<TodosFilterState> emit){

    if(state is TodosFilterLoading){

        add(
          const UpdateTodos(
            todosFilter: TodosFilter.pending
          )
        );

    }

    if(state is TodosFilterLoaded){
      final state = this.state as TodosFilterLoaded;

      add(
        UpdateTodos(
          todosFilter: state.todosFilter
        )
      );
    }

  }

 
  void _onUpdateTodos(UpdateTodos event, Emitter<TodosFilterState> emit){

    final state = _todoBloc.state;

    if(state is TodosLoaded){
      List<Todo> todos = state.todos.where(
          (todo){
            switch (event.todosFilter){
              case TodosFilter.all:
                return true;

              case TodosFilter.completed:
                return todo.isCompleted!;// ?? false;

              case TodosFilter.cancelled:
                return todo.isCancelled!;// ?? false;

              case TodosFilter.pending:
                return !(todo.isCancelled! || todo.isCompleted!);
            }

          }
      ).toList();
      
      emit(
        TodosFilterLoaded(filtered: todos)
      );
    }

  }

}