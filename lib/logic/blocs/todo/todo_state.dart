part of 'todo_bloc.dart';

@immutable
abstract class TodoBlocState {
  final List<Todo>? todos;

  const TodoBlocState({this.todos});
}

class TodoInitial extends TodoBlocState {
  final List<Todo>? todos;

  const TodoInitial({this.todos});
}

class TodoToggled extends TodoBlocState {}

class TodoLoaded extends TodoBlocState {
  final List<Todo> todos;

  const TodoLoaded(this.todos) : super(todos: todos);
}

class DeletedTodo extends TodoBlocState {}

class AddedTodo extends TodoBlocState {}
class EditedTodo extends TodoBlocState{}

class ErrorTodo extends TodoBlocState{
  String? message;
  ErrorTodo({this.message});
}
