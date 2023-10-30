import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_cubit_review/logic/blocs/todo/todo_bloc.dart';

import '../../data/models/todo.dart';
import '../../logic/cubits/todo/todo_cubit.dart';
import 'manage_todo.dart';

class TodosListItem extends StatelessWidget {
  final Todo todo;

  const TodosListItem({
    required this.todo,
    super.key,
  });

  Future<dynamic> openManageTodo(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        showDragHandle: true,
        context: context,
        builder: (ctx) => ManageTodo(
              todo: todo,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(todo.time)),
      leading: IconButton(
        onPressed: () =>
            context.read<TodoBloc>().add(ToggleTodoEvent(id: todo.id)),
        icon: todo.isDone
            ? const Icon(
                Icons.check_circle_rounded,
                color: Colors.lightGreen,
              )
            : const Icon(Icons.circle_outlined),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () =>
                context.read<TodoBloc>().add(DeletedTodoEvent(id: todo.id)),
            icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
          ),
          IconButton(
            onPressed: () => openManageTodo(context),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}
