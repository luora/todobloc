import 'package:equatable/equatable.dart';
import 'package:todobloc/models/models.dart';

abstract class TodoState extends Equatable {

  const TodoState();

  @override
  List<Object> get props => [];
}


enum TodoLoadingStatus {loading, loaded }


class TodosLoading extends TodoState{
}



class TodosLoaded extends TodoState {

  final List<Todo> todos;

  const TodosLoaded({ this.todos = const <Todo>[]});

  TodosLoaded copyWith({List<Todo>? todos}){
    return TodosLoaded(todos: todos ?? this.todos);
  }

  @override
  List<Object> get props => [todos];

}