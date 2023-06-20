import 'package:flutter/material.dart';

class Provider<M> extends InheritedWidget {
  final M model;

  const Provider({super.key, required this.model, required super.child});

  static M? of<M>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider<M>>()?.model;
  }

  static M? getModel<M>(BuildContext context) {
    final widget =
        context.getElementForInheritedWidgetOfExactType<Provider<M>>()?.widget;
    final model = widget is Provider ? widget.model : null;
    return model;
  }

  @override
  bool updateShouldNotify(covariant Provider oldWidget) {
    return model != oldWidget.model;
  }
}
