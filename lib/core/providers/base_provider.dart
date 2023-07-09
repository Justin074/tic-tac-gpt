import 'package:flutter/material.dart';

typedef ClassCreator<T> = T Function();

class BaseProvider<T> extends ChangeNotifier {
  late ValueNotifier<T> valueProvider;

  /// Usage:
  /// Give the creator an empty instance of your class
  /// eg. T = List<int>
  /// classCreator = () => <int>[]
  final ClassCreator<T> classCreator;

  BaseProvider({
    required this.classCreator,
  }) {
    valueProvider = ValueNotifier<T>(classCreator());
  }

  void notifyClients() {
    valueProvider.notifyListeners();
  }
}
