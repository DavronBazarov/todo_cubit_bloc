import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../../data/models/todo.dart';
import '../todo/todo_cubit.dart';

part 'completed_state.dart';

class CompletedCubit extends Cubit<CompletedState> {
  final TodoCubit? todoCubit;

  CompletedCubit({this.todoCubit}) : super(CompletedInitial());

  void getTodoCompleted() {
    final todos = todoCubit!.state.todos!.where((todo) => todo.isDone).toList();
    emit(CompletedTodosLoaded(todos: todos));
  }
}
