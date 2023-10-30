import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/todo.dart';
import '../todo/todo_bloc.dart';

part 'completed_event.dart';

part 'completed_state.dart';

class CompletedBloc extends Bloc<CompletedEvent, CompletedState> {
  final TodoBloc? todoBloc;

  CompletedBloc({this.todoBloc}) : super(CompletedInitial()) {
    on<LoadedCompletedEvent>(_getTodoCompleted);
  }

  void _getTodoCompleted(
      LoadedCompletedEvent event, Emitter<CompletedState> emit) {
    final todos = todoBloc!.state.todos!.where((todo) => todo.isDone).toList();
    emit(CompletedTodosLoaded(todos: todos));
  }
}
