class TaskItem {
  final String id;
  final String title;
  final Importance? importance;
  final DateTime? date;
  final bool isDone;

  TaskItem({
    required this.id,
    required this.title,
    this.importance,
    this.date,
    this.isDone = false,
  });

  TaskItem copyWith({
    String? id,
    String? title,
    Importance? importance,
    DateTime? date,
    bool? isDone,
  }) {
    return TaskItem(
      id: id ?? this.id,
      title: title ?? this.title,
      importance: importance ?? this.importance,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
    );
  }
}

enum Importance { low, high }
