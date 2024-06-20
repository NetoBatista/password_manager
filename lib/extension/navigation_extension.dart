import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  Future<T?> pushNamedAndRemoveUntil<T>(String routeName) {
    return Navigator.pushNamedAndRemoveUntil(
      this,
      routeName,
      (Route route) => route.isFirst,
    );
  }

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  T? args<T>() {
    return ModalRoute.of(this)!.settings.arguments as T?;
  }

  void pop({dynamic result}) {
    return Navigator.pop(this, result);
  }
}
