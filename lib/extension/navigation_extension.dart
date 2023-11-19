import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  Future<T?> pushNamed<T>(String routeName) {
    return Navigator.pushNamed(this, routeName);
  }

  void pop() {
    return Navigator.pop(this);
  }
}
