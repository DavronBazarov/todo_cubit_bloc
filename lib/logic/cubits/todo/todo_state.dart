part of 'todo_cubit.dart';

@immutable
abstract class TodoState {
  final List<Todo>? todos;

  const TodoState({this.todos});
}

class TodoInitial extends TodoState {
  final List<Todo>? todos;

  const TodoInitial({this.todos});
}

class TodoToggled extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;

  const TodoLoaded(this.todos) : super(todos: todos);
}

class DeletedTodo extends TodoState {}

class AddedTodo extends TodoState {}
class EditedTodo extends TodoState{}

class ErrorTodo extends TodoState{
  String? message;
  ErrorTodo({this.message});
}
