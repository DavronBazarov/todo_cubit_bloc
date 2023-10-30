import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_review/logic/blocs/todo/todo_bloc.dart';

import '../../data/models/todo.dart';
import '../../logic/cubits/todo/todo_cubit.dart';

class ManageTodo extends StatelessWidget {
  Todo? todo;

  ManageTodo({
    super.key,
    this.todo,
  });

  final _formKey = GlobalKey<FormState>();
  String _title = '';

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (todo == null) {
        // context.read<TodoCubit>().addTodo(_title);
        context.read<TodoBloc>().add(AddNewTodoEvent(title: _title));
        Navigator.of(context).pop();
      } else {
        // context.read<TodoCubit>().editTodo(todo!.id, _title);
        context
            .read<TodoBloc>()
            .add(EditTodoEvent(id: todo!.id, title: _title));
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                initialValue: todo == null ? "" : todo!.title,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter title!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("CANCEL")),
                  const SizedBox(width: 40),
                  ElevatedButton(
                      onPressed: () {
                        _submit(context);
                      },
                      child: Text(todo == null ? "ADD" : "EDIT")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
