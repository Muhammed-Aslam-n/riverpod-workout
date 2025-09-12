import 'package:hive/hive.dart';

part 'todo_adapter.g.dart';

@HiveType(typeId: 1)
class TodoData {
  TodoData({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.isDeleted = false,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  bool isCompleted;

  @HiveField(4)
  bool isDeleted;

  @override
  String toString() {
    return 'id: $id title: $title: description: $description isCompleted $isCompleted isDeleted $isDeleted';
  }

  // copyWith method
  TodoData copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
    bool? isDeleted,
  }) {
    return TodoData(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
