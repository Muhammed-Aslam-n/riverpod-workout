import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_riverpod/provider/home_screen/home_screen_provider.dart';
import 'package:todo_app_riverpod/widget/empty_state_widget.dart';
import 'package:todo_app_riverpod/widget/floating_add_button.dart';
import 'package:todo_app_riverpod/widget/todo_list_view.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoAsync = ref.watch(todoProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: todoAsync.when(
        data: (todos) {
          return todos.isEmpty
              ? EmptyStateWidget(onAddTask: () {})
              : TodoListView(
                  todos: todos,
                  onEdit: _startEditTodo,
                  onDelete: _deleteTodo,
                  onToggle: _toggleTodo,
                );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingAddButton(onPressed: _startAddTodo),
    );
  }

  void _startAddTodo() {
    final todoAsync = ref.read(todoProvider.notifier);
    todoAsync.addTodo(title: 'Sample 1');
    todoAsync.getAllTodos();
  }

  void _startEditTodo(int index) {

  }

  void _deleteTodo(int index) {
    // final todoAsync = ref.read(todoProvider.notifier);
    // final res = todoAsync
  }

  void _toggleTodo(int index, bool? value) {}
}
