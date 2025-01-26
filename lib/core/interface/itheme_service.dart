import 'package:flutter/material.dart';

abstract class IThemeService {
  Future<void> init();

  ValueNotifier<ThemeMode> getCurrent();

  Future<void> change(
    ThemeMode theme,
  );
}
