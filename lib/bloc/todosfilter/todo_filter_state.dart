import 'package:equatable/equatable.dart';
import 'package:todobloc/bloc/todosfilter/todo_filter_model.dart';
import 'package:todobloc/models/models.dart';

abstract class TodosFilterState extends Equatable {

  const TodosFilterState();

  @override
  List<Object> get props => [];

}

class TodosFilterInitial extends TodosFilterState {

}

class TodosFilterLoading extends TodosFilterState {

}

class TodosFilterLoaded extends TodosFilterState {

  final List<Todo> filtered;
  final TodosFilter todosFilter;

  const TodosFilterLoaded({
    required this.filtered,
    this.todosFilter = TodosFilter.all});


  @override
  List<Object> get props => [
    filtered,
    todosFilter
  ];

}