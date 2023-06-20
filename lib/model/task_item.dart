enum Importance { low, high }

class TaskItem {
  final String id;
  final String title;
  final Importance? importance;
  final DateTime? date;
  final bool isDone;
  final String? stringColor;
  final int createdAt;
  final int changedAt;
  final String lastUpdatedBy;

  TaskItem({
    required this.id,
    required this.title,
    this.importance,
    this.date,
    this.isDone = false,
    this.stringColor,
    required this.changedAt,
    required this.createdAt,
    required this.lastUpdatedBy,
  });

  TaskItem copyWith({
    String? id,
    String? title,
    Importance? importance,
    DateTime? date,
    bool? isDone,
    String? stringColor,
    int? createdAt,
    int? changedAt,
    String? lastUpdatedBy,
  }) {
    return TaskItem(
      id: id ?? this.id,
      title: title ?? this.title,
      importance: importance ?? this.importance,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      stringColor: stringColor ?? this.stringColor,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
    );
  }
}
