import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_riverpod/config/db/todo_adapter.dart';
import 'package:todo_app_riverpod/services/db_services.dart';


final dbHelperProvider = Provider<DatabaseContract>((ref) => DatabaseHelper());

final todoProvider = AsyncNotifierProvider<TodoNotifier, List<TodoData>>(
  () => TodoNotifier(),
);

class TodoNotifier extends AsyncNotifier<List<TodoData>> {
  @override
  Future<List<TodoData>> build() async {
    await Future.delayed(Duration(milliseconds: 1700));
    final db = ref.read(dbHelperProvider);
    return await db.getAllTodos();
  }

  Future<bool> addTodo({
    required String title,
    String? description,
    bool? isCompleted,
  }) async {
    final db = ref.watch(dbHelperProvider);

    final TodoData todoData = TodoData(
      id: lastSavedId,
      title: title,
      description: description,
      isCompleted: isCompleted ?? false,
    );
    return await db.saveTodo(todo: todoData);
  }

  // Load all todos from the database
  Future<void> getAllTodos() async {
    final db = ref.read(dbHelperProvider);
    final todos = await db.getAllTodos();
    state = AsyncValue.data(todos);
  }
}
