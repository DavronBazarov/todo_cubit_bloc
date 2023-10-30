import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../logic/cubits/todo/todo_cubit.dart';

class SearchBarDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () {},
        child: const Text(
          "CLEAR",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(
          CupertinoIcons.back,
          color: Colors.black,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    final todos = context.read<TodoCubit>().searchTodo(query: query);
    if (query.isNotEmpty) {
      return todos.isEmpty
          ? const Center(
        child: Text("Can't find todo!"),
      )
          : ListView.builder(
        itemCount: todos.length,
        itemBuilder: (ctx, index) {
          final todo = todos[index];
          return ListTile(title: Text(todo.title));
        },
      );
    }
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final todos = context.read<TodoCubit>().searchTodo(query: query);
    if (query.isNotEmpty) {
      return todos.isEmpty
          ? const Center(
              child: Text("Can't find todo!"),
            )
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (ctx, index) {
                final todo = todos[index];
                return ListTile(title: Text(todo.title));
              },
            );
    }
    return Container();
  }
}
