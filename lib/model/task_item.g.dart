// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskItemAdapter extends TypeAdapter<TaskItem> {
  @override
  final int typeId = 0;

  @override
  TaskItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskItem(
      id: fields[0] as String,
      title: fields[1] as String,
      importance: fields[2] as Importance,
      date: fields[3] as DateTime?,
      isDone: fields[4] as bool,
      stringColor: fields[5] as String?,
      changedAt: fields[7] as int,
      createdAt: fields[6] as int,
      lastUpdatedBy: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TaskItem obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.importance)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.isDone)
      ..writeByte(5)
      ..write(obj.stringColor)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.changedAt)
      ..writeByte(8)
      ..write(obj.lastUpdatedBy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ImportanceAdapter extends TypeAdapter<Importance> {
  @override
  final typeId = 1; // Уникальный идентификатор для адаптера

  @override
  Importance read(BinaryReader reader) {
    return Importance.values[reader.readInt()];
  }

  @override
  void write(BinaryWriter writer, Importance obj) {
    writer.writeInt(obj.index);
  }
}

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
