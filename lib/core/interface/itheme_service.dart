import 'package:flutter/material.dart';

abstract class IThemeService {
  ValueNotifier<ThemeMode> getCurrent();

  Future<void> change(
    ThemeMode theme,
  );
}
