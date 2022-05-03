import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String task;
  final String description;
  bool? isCompleted;
  bool? isCancelled;

  Todo({required this.id, required this.task, required this.description, this.isCancelled, this.isCompleted}) {
    isCompleted = isCompleted ?? false;
    isCancelled = isCancelled ?? false;
  }

  Todo copyWith({
    String? id,
    String? task,
    String? description,
    bool? isCancelled,
    bool? isCompleted
}) {
    return Todo(
        id: id ?? this.id,
        task: task ?? this.task,
        description: description ?? this.description,
        isCancelled: isCancelled ?? this.isCancelled,
        isCompleted: isCompleted ?? this.isCompleted,
    );
}

@override
  List<Object?> get props => [
  id,
  task,
  description,
  isCompleted,
  isCancelled,
];

  static List<Todo> todos = [
    Todo(id: '1', task: "simple Todo 1", description: "Test todo 1"),
    Todo(id: '2', task: "simple Todo 2" , description: "Test todo 2"),
  ];


}
