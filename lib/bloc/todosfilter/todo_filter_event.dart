
import 'package:equatable/equatable.dart';
import 'package:todobloc/bloc/todosfilter/todo_filter_model.dart';

abstract class TodosFilterEvent extends Equatable {

  const TodosFilterEvent();

  @override
  List<Object> get props => [];

}

class UpdateTodos extends TodosFilterEvent {

  final TodosFilter todosFilter;

  const UpdateTodos({this.todosFilter = TodosFilter.all});


  @override
  List<Object> get props => [todosFilter];


}


class UpdateFilter extends TodosFilterEvent{

  const UpdateFilter();

  @override
  List<Object> get props => [];

}

