import 'package:hive/hive.dart';
import 'package:todo_app_riverpod/config/db/todo_adapter.dart';
import 'package:todo_app_riverpod/constants/app_constants.dart';
import 'package:todo_app_riverpod/logger/logger.dart';

int lastSavedId = 0;

abstract class DatabaseContract {
  Future<bool> saveTodo({required TodoData todo});

  Future<TodoData?> updateTodo({required TodoData todo});

  Future<List<TodoData>> getAllTodos();

  Future<TodoData?> getSingleTodo({required int id});

  Future<bool> deleteTodo({required int id});
}

class DatabaseHelper implements DatabaseContract {
  final Box<TodoData> _todoBox = Hive.box<TodoData>(DbConstants.todoTable);

  @override
  Future<bool> saveTodo({required TodoData todo}) async {
    try {
      dp('saveTodoCalled ${todo.toString()}');
      final res = await _todoBox.add(todo);
      lastSavedId++;
      dp('resOfSaveTodo $res - $lastSavedId');
      return true;
    } on Exception catch (e, s) {
      dp('ExceptionCaughtWhileTodo \n$e \n $s');
      return false;
    }
  }

  @override
  Future<TodoData?> updateTodo({required TodoData todo}) async {
    try {
      final itemIndex = _todoBox.values.toList().indexWhere(
        (item) => todo.id == item.id,
      );
      if (itemIndex == -1) return null;
      await _todoBox.putAt(itemIndex, todo);
      return todo;
    } on Exception catch (e, s) {
      dp('ExceptionCaughtWhileTodo \n$e \n $s');
    }
    return null;
  }

  @override
  Future<List<TodoData>> getAllTodos() async {
    try {
      return _todoBox.values.where((todos) => !todos.isDeleted).toList();
    } on Exception catch (e, s) {
      dp('ExceptionCaughtWhileTodo \n$e \n $s');
    }
    return [];
  }

  @override
  Future<TodoData?> getSingleTodo({required int id}) async {
    try {} on Exception catch (e, s) {
      dp('ExceptionCaughtWhileTodo \n$e \n $s');
    }
    return null;
  }

  @override
  Future<bool> deleteTodo({required int id}) async {
    try {
      final index = _todoBox.values.toList().indexWhere((t) => t.id == id);
      if (index == -1) return false;
      final todo = _todoBox.getAt(index)!.copyWith(isDeleted: true);
      await _todoBox.putAt(index, todo); // Soft delete
      return true;
    } catch (e) {
      print('Error deleting todo: $e');
      return false;
    }
  }
}
