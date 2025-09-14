import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_riverpod/common/app_toaster.dart';
import 'package:todo_app_riverpod/common/dialogs/custom_dialog.dart';
import 'package:todo_app_riverpod/config/db/todo_adapter.dart';
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
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text('Clear All'),
                  onTap: () {
                    showConfirmClearAllData();
                  },
                ),
              ];
            },
          ),
        ],
      ),
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

  void _startAddTodo() async {
    final bool? isAdded = await context.push<bool>('/addEdit');
    if (isAdded == true && mounted) {
      AppToaster.success(context, message: 'Todo added successfully');
    } else if (mounted) {
      AppToaster.error(context, message: 'Failed to add todo');
    }
    final todoAsync = ref.read(todoProvider.notifier);
    todoAsync.getAllTodos();
  }

  void _startEditTodo(TodoData todo) async {
    final bool? result = await context.push<bool>('/addEdit', extra: todo);
    if (result == true && mounted) {
      AppToaster.success(context, message: 'Todo updated successfully');
    } else if (mounted) {
      AppToaster.error(context, message: 'Failed to update todo');
    }
    final todoAsync = ref.read(todoProvider.notifier);
    todoAsync.getAllTodos();
  }

  void _deleteTodo(int index) {
    // final todoAsync = ref.read(todoProvider.notifier);
    // final res = todoAsync
  }

  void _toggleTodo(int index, bool? value) {}

  void showConfirmClearAllData() {
    // showCustomDialog(context: context, child: Text('Are you sure?'));
    final todoAsync = ref.read(todoProvider.notifier);
    todoAsync.clearAllData();
    AppToaster.success(context, message: 'Todos cleared successfully');
  }
}
