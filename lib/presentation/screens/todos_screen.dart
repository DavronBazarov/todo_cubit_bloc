import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_review/constants/tab_titles_constants.dart';
import 'package:todo_cubit_review/logic/blocs/active/active_bloc.dart';
import 'package:todo_cubit_review/logic/blocs/completed/completed_bloc.dart';
import 'package:todo_cubit_review/logic/blocs/todo/todo_bloc.dart';
// import 'package:todo_cubit_review/logic/cubits/todo/todo_cubit.dart';

// import '../../logic/cubits/active_todos/active_cubit.dart';
// import '../../logic/cubits/completed/completed_cubit.dart';

// import '../../logic/cubits/todo/todo_cubit.dart';

import '../widgets/manage_todo.dart';
import '../widgets/search_bar.dart';

import '../widgets/todo_list_item.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  bool _init = true;

  @override
  void didChangeDependencies() {
    if (_init) {
      // context.read<TodoCubit>().getTodos();
      context.read<TodoBloc>().add(LoadTodosEvent());
      // context.read<ActiveCubit>().getActiveTodos();
      context.read<ActiveBloc>().add(LoadedActiveTodosEvent());
      // context.read<CompletedCubit>().getTodoCompleted();
      context.read<CompletedBloc>().add(LoadedCompletedEvent());
    }
    _init = false;
    super.didChangeDependencies();
  }

  void openManageTodo(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      showDragHandle: true,
      context: context,
      builder: (ctx) => ManageTodo(
        todo: null,
      ),
    );
  }

  void openSearchBar(BuildContext context) {
    showSearch(context: context, delegate: SearchBarDelegate());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 1000),
      length: TabTitlesConstants.tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Todos Screen"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => openSearchBar(context),
              icon: const Icon(CupertinoIcons.search),
            ),
            const SizedBox(width: 20),
          ],
          bottom: TabBar(
              tabs: TabTitlesConstants.tabs
                  .map(
                    (e) => Tab(
                      child: Text(e),
                    ),
                  )
                  .toList()),
        ),
        body: BlocListener<TodoBloc, TodoBlocState>(
          listener: (context, state) {
            context.read<ActiveBloc>().add(LoadedActiveTodosEvent());
            context.read<CompletedBloc>().add(LoadedCompletedEvent());
          },
          child: TabBarView(children: [
            BlocBuilder<TodoBloc, TodoBlocState>(builder: (ctx, state) {
              if (state is TodoLoaded) {
                if (state.todos.isNotEmpty) {
                  return ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) => TodosListItem(
                      todo: state.todos[index],
                    ),
                  );
                }
                return const Center(child: Text("No data!"));
              }
              return const Center(child: Text("Xatolik sodir bo'ldi"));
            }),
            BlocBuilder<ActiveBloc, ActiveState>(builder: (ctx, state) {
              if (state is ActiveTodosLoaded) {
                if (state.todos.isNotEmpty) {
                  return ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) => TodosListItem(
                      todo: state.todos[index],
                    ),
                  );
                }
                return const Center(child: Text("No data!"));
              }
              return const Center(child: Text("Xatolik sodir bo'ldi"));
            }),
            BlocBuilder<CompletedBloc, CompletedState>(builder: (ctx, state) {
              if (state is CompletedTodosLoaded) {
                if (state.todos!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: state.todos!.length,
                    itemBuilder: (context, index) => TodosListItem(
                      todo: state.todos![index],
                    ),
                  );
                }
                return const Center(child: Text("No data!"));
              }
              return const Center(child: Text("Xatolik sodir bo'ldi"));
            }),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => openManageTodo(context),
          child: const Icon(Icons.add_outlined),
        ),
      ),
    );
  }
}
