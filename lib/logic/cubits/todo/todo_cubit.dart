import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../data/models/todo.dart';

import '../user/user_cubit.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final UserCubit userCubit;

  TodoCubit({required this.userCubit})
      : super(
          TodoInitial(
            todos: [
              Todo(
                id: UniqueKey().toString(),
                title: "Go home",
                userId: '1',
                isDone: true,
                time: DateTime.now(),
              ),
              Todo(
                  id: UniqueKey().toString(),
                  title: "Go to work",
                  userId: '1',
                  time: DateTime.now(),
                  isDone: false),
              Todo(
                  id: UniqueKey().toString(),
                  title: "Go to university",
                  userId: '2',
                  time: DateTime.now(),
                  isDone: false),
              Todo(
                  id: UniqueKey().toString(),
                  title: "Go to swimming pol",
                  userId: '2',
                  time: DateTime.now(),
                  isDone: true),
            ],
          ),
        );

  void getTodos() {
    final user = userCubit.currentUser;
    final todos =
        state.todos!.where((todo) => todo.userId == user.userId).toList();
    emit(TodoLoaded(todos));
  }

  void addTodo(String title) {
    final user = userCubit.currentUser;
    final todo = Todo(
      id: UniqueKey().toString(),
      userId: user.userId,
      title: title,
      time: DateTime.now(),
    );
    final todos = [...state.todos!, todo];
    emit(AddedTodo());
    emit(TodoLoaded(todos));
  }

  void editTodo(String id, String title) {
    final todos = state.todos!.map((todo) {
      if (todo.id == id) {
        return Todo(
          id: todo.id,
          title: title,
          userId: todo.userId,
          time: todo.time,
          isDone: todo.isDone,
        );
      }
      return todo;
    }).toList();
    emit(EditedTodo());
    emit(TodoLoaded(todos));
  }

  void deleteToggle(String id) {
    final todos = state.todos;
    todos!.removeWhere((todo) => todo.id == id);
    emit(DeletedTodo());
    emit(TodoLoaded(todos));
  }

  void todoToggled(String id) {
    final todos = state.todos!.map((todo) {
      if (todo.id == id) {
        return Todo(
          id: todo.id,
          title: todo.title,
          userId: todo.userId,
          isDone: !todo.isDone,
          time: todo.time,
        );
      }
      return todo;
    }).toList();
    emit(TodoToggled());
    emit(TodoLoaded(todos));
  }

  List<Todo> searchTodo({required String query}) {
    return state.todos!
        .where((todo) => todo.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
