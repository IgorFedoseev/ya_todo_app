import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_item.g.dart';

enum Importance { no, low, high }

@HiveType(typeId: 0)
class TaskItem {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final Importance importance;
  @HiveField(3)
  final DateTime? date;
  @HiveField(4)
  final bool isDone;
  @HiveField(5)
  final String? stringColor;
  @HiveField(6)
  final int createdAt;
  @HiveField(7)
  final int changedAt;
  @HiveField(8)
  final String lastUpdatedBy;

  TaskItem({
    required this.id,
    required this.title,
    required this.importance,
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

  factory TaskItem.fromJson(Map<String, dynamic> json) =>
      _$TaskItemFromJson(json);
  Map<String, dynamic> toJson() => _$TaskItemToJson(this);

  @override
  String toString() {
    return 'TaskItem{'
        'id: $id, '
        'title: $title, '
        'importance: $importance, '
        'date: $date, '
        'isDone: $isDone, '
        'stringColor: $stringColor, '
        'createdAt: $createdAt, '
        'changedAt: $changedAt, '
        'lastUpdatedBy: $lastUpdatedBy'
        '}';
  }
}
