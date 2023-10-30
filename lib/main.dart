import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_review/logic/blocs/active/active_bloc.dart';
import 'package:todo_cubit_review/logic/blocs/completed/completed_bloc.dart';
import 'package:todo_cubit_review/logic/blocs/user/user_bloc.dart';

import 'package:todo_cubit_review/presentation/screens/todos_screen.dart';

import 'logic/blocs/todo/todo_bloc.dart';
import 'logic/cubits/active_todos/active_cubit.dart';
import 'logic/cubits/completed/completed_cubit.dart';
import 'logic/cubits/todo/todo_cubit.dart';
import 'logic/cubits/user/user_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) => UserCubit(),
          ),
          BlocProvider(
            create: (ctx) => TodoCubit(userCubit: ctx.read<UserCubit>()),
          ),
          BlocProvider(
            create: (ctx) => ActiveCubit(todoCubit: ctx.read<TodoCubit>()),
          ),
          BlocProvider(
            create: (ctx) => CompletedCubit(todoCubit: ctx.read<TodoCubit>()),
          ),
          BlocProvider(create: (ctx) => UserBloc()),
          BlocProvider(
            create: (ctx) => TodoBloc(userBloc: ctx.read<UserBloc>()),
          ),
          BlocProvider(
            create: (ctx) => ActiveBloc(todoBloc: ctx.read<TodoBloc>()),
          ),
          BlocProvider(
            create: (ctx) => CompletedBloc(todoBloc: ctx.read<TodoBloc>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const TodosScreen(),
        ));
  }
}
