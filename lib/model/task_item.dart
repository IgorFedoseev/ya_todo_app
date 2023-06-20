import 'package:json_annotation/json_annotation.dart';

part 'task_item.g.dart';

enum Importance { low, high }

@JsonSerializable()
class TaskItem {
  final String id;
  @JsonKey(name: "text")
  final String title;
  final Importance? importance;
  @JsonKey(name: "deadline")
  final DateTime? date;
  @JsonKey(name: "done")
  final bool isDone;
  @JsonKey(name: "color")
  final String? stringColor;
  @JsonKey(name: "created_at")
  final int createdAt;
  @JsonKey(name: "changed_at")
  final int changedAt;
  @JsonKey(name: "last_updated_by")
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

  factory TaskItem.fromJson(Map<String, dynamic> json) =>
      _$TaskItemFromJson(json);
  Map<String, dynamic> toJson() => _$TaskItemToJson(this);
}
