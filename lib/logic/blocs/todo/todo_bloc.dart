

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../data/models/todo.dart';
import '../user/user_bloc.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoBlocState> {
  final UserBloc? userBloc;

  TodoBloc({this.userBloc})
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
        ) {
    on<LoadTodosEvent>(_getTodos);
    on<AddNewTodoEvent>(_addTodo);
    on<EditTodoEvent>(_editTodo);
    on<DeletedTodoEvent>(_deleteTodo);
    on<ToggleTodoEvent>(_todoToggled);
  }

  void _getTodos(LoadTodosEvent event, Emitter<TodoBlocState> emit) {
    final user = userBloc!.currentUser;
    final todos =
        state.todos!.where((todo) => todo.userId == user.userId).toList();
    emit(TodoLoaded(todos));
  }

  void _addTodo(AddNewTodoEvent event, Emitter<TodoBlocState> emit) {
    final user = userBloc!.currentUser;
    final todo = Todo(
      id: UniqueKey().toString(),
      userId: user.userId,
      title: event.title!,
      time: DateTime.now(),
    );
    final todos = [...state.todos!, todo];
    emit(AddedTodo());
    emit(TodoLoaded(todos));
  }

  void _editTodo(EditTodoEvent event, Emitter<TodoBlocState> emit) {
    final todos = state.todos!.map((todo) {
      if (todo.id == event.id) {
        return Todo(
          id: todo.id,
          title: event.title!,
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

  void _deleteTodo(DeletedTodoEvent event, Emitter<TodoBlocState> emit) {
    final todos = state.todos;
    todos!.removeWhere((todo) => todo.id == event.id);
    emit(DeletedTodo());
    emit(TodoLoaded(todos));
  }

  void _todoToggled(ToggleTodoEvent event, Emitter<TodoBlocState> emit) {
    final todos = state.todos!.map((todo) {
      if (todo.id == event.id) {
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
