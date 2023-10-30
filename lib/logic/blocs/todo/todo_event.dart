part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class LoadTodosEvent extends TodoEvent {}

class AddNewTodoEvent extends TodoEvent {
  final String? title;

  AddNewTodoEvent({this.title});
}

class EditTodoEvent extends TodoEvent {
  final String? id;
  final String? title;

  EditTodoEvent({this.id, this.title});
}

class DeletedTodoEvent extends TodoEvent {
  final String? id;

  DeletedTodoEvent({this.id});
}
class ToggleTodoEvent extends TodoEvent{
  final String? id;
  ToggleTodoEvent({this.id});
}
