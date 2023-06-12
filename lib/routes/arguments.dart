import '../model/task_item.dart';

class TastScreenArguments {
  final Function(TaskItem) onCreate;
  final Function(TaskItem) onUpdate;
  final TaskItem? originalItem;

  TastScreenArguments(this.onCreate, this.onUpdate, this.originalItem);
}
