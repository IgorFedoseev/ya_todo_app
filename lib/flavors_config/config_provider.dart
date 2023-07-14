import 'package:flutter/material.dart';
import 'package:ya_todo_list/flavors_config/todo_config.dart';

class ConfigProvider extends InheritedWidget {
  final TodoConfig config;

  const ConfigProvider({
    required this.config,
    required super.child,
    super.key,
  });

  static TodoConfig? of(BuildContext context) {
    final element =
        context.getElementForInheritedWidgetOfExactType<ConfigProvider>();
    final provider = element?.widget;
    final config = provider is ConfigProvider ? provider.config : null;
    return config;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
