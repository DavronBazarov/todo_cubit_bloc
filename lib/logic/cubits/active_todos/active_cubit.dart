import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../../data/models/todo.dart';
import '../todo/todo_cubit.dart';

part 'active_state.dart';

class ActiveCubit extends Cubit<ActiveState> {
  final TodoCubit? todoCubit;

  ActiveCubit({this.todoCubit}) : super(ActiveInitial());

  void getActiveTodos() {
    final todos =
        todoCubit!.state.todos!.where((todo) => !todo.isDone).toList();
    emit(ActiveTodosLoaded(todos));
  }
}
