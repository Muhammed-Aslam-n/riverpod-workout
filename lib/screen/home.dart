import 'package:flutter/material.dart';
import 'package:todo_app_riverpod/widget/add_edit_todo_form.dart';
import 'package:todo_app_riverpod/widget/empty_state_widget.dart';
import 'package:todo_app_riverpod/widget/floating_add_button.dart';
import 'package:todo_app_riverpod/widget/todo_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> todos = [];
  bool isAdding = false;
  bool isEditing = false;
  int? editingIndex;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    _fetchScrapData();
  }

  // Simulate fetching data (scrap data from some source)
  void _fetchScrapData() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        todos = [
          {
            'title': 'Buy groceries',
            'description': 'Milk, eggs, bread',
            'isCompleted': false,
          },
          {
            'title': 'Schedule appointment',
            'description': 'Call the doctor',
            'isCompleted': false,
          },
          {
            'title': 'Study for exam',
            'description': 'Read chapter 5',
            'isCompleted': false,
          },
        ];
      });
    });
  }

  void _startAddTodo() {
    setState(() {
      isAdding = true;
      isEditing = false;
      titleController.clear();
      descriptionController.clear();
      isCompleted = false;
    });
  }

  void _startEditTodo(int index) {
    final todo = todos[index];
    setState(() {
      isAdding = true;
      isEditing = true;
      editingIndex = index;
      titleController.text = todo['title'];
      descriptionController.text = todo['description'];
      isCompleted = todo['isCompleted'];
    });
  }

  void _saveTodo() {
    final newTodo = {
      'title': titleController.text,
      'description': descriptionController.text,
      'isCompleted': isCompleted,
    };

    setState(() {
      if (isEditing && editingIndex != null) {
        todos[editingIndex!] = newTodo;
      } else {
        todos.add(newTodo);
      }
      isAdding = false;
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void _toggleTodo(int index, bool? value) {
    setState(() {
      todos[index]['isCompleted'] = value ?? false;
    });
  }

  void _cancel() {
    setState(() {
      isAdding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: isAdding
          ? AddEditTodoForm(
              titleController: titleController,
              descriptionController: descriptionController,
              isCompleted: isCompleted,
              onCompletedChanged: (value) =>
                  setState(() => isCompleted = value),
              onSave: _saveTodo,
              onCancel: _cancel,
            )
          : todos.isEmpty
          ? EmptyStateWidget(onAddTask: _startAddTodo)
          : TodoListView(
              todos: todos,
              onEdit: _startEditTodo,
              onDelete: _deleteTodo,
              onToggle: _toggleTodo,
            ),
      floatingActionButton: isAdding
          ? null
          : FloatingAddButton(onPressed: _startAddTodo),
    );
  }
}
