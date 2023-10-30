import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/todo.dart';
import '../todo/todo_bloc.dart';

part 'active_event.dart';

part 'active_state.dart';

class ActiveBloc extends Bloc<ActiveEvent, ActiveState> {
  final TodoBloc? todoBloc;

  ActiveBloc({this.todoBloc}) : super(ActiveInitial()) {
    on<LoadedActiveTodosEvent>(_getActiveTodos);
  }

  void _getActiveTodos(
      LoadedActiveTodosEvent event, Emitter<ActiveState> emit) {
    final todos = todoBloc!.state.todos!.where((todo) => !todo.isDone).toList();
    emit(ActiveTodosLoaded(todos));
  }
}
