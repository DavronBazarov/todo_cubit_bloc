part of 'active_bloc.dart';

@immutable
abstract class ActiveState {}

class ActiveInitial extends ActiveState {}
class ActiveTodosLoaded extends ActiveState{
  final List<Todo> todos;
  ActiveTodosLoaded(this.todos);
}