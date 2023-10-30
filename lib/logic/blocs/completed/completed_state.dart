part of 'completed_bloc.dart';

@immutable
abstract class CompletedState {}

class CompletedInitial extends CompletedState {}
class CompletedTodosLoaded extends CompletedState{
  final List<Todo>? todos;
  CompletedTodosLoaded({this.todos});
}