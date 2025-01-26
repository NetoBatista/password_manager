import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension ContextExtension on BuildContext {
  T watchContext<T>() {
    return watch<T>();
  }

  T readContext<T>() {
    return read<T>();
  }
}
