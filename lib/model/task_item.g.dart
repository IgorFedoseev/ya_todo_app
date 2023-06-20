// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskItem _$TaskItemFromJson(Map<String, dynamic> json) => TaskItem(
      id: json['id'] as String,
      title: json['text'] as String,
      importance: $enumDecode(_$ImportanceEnumMap, json['importance']),
      date: json['deadline'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['deadline'] as int),
      isDone: json['done'] as bool? ?? false,
      stringColor: json['color'] as String?,
      changedAt: json['changed_at'] as int,
      createdAt: json['created_at'] as int,
      lastUpdatedBy: json['last_updated_by'] as String,
    );

Map<String, dynamic> _$TaskItemToJson(TaskItem instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.title,
      'importance': _$ImportanceEnumMap[instance.importance] ?? 'basic',
      'deadline': instance.date?.millisecondsSinceEpoch,
      'done': instance.isDone,
      'color': instance.stringColor,
      'created_at': instance.createdAt,
      'changed_at': instance.changedAt,
      'last_updated_by': instance.lastUpdatedBy,
    };

const _$ImportanceEnumMap = {
  Importance.low: 'low',
  Importance.high: 'important',
  Importance.no: 'basic',
};
