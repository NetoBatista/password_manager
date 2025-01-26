import 'package:flutter/material.dart';
import 'package:password_manager/core/interface/itheme_service.dart';
import 'package:password_manager/core/provider/dependency_provider.dart';
import 'package:password_manager/shared/default_state_shared.dart';

class ThemeController extends ValueNotifier<IDefaultStateShared> {
  ThemeController() : super(DefaultStateShared());

  final IThemeService _themeService = DependencyProvider.get();
  ValueNotifier<ThemeMode> getCurrentTheme() => _themeService.getCurrent();
  ValueNotifier<ThemeMode> themeSelected = ValueNotifier(ThemeMode.system);

  void init() {
    var currentTheme = getCurrentTheme();
    themeSelected.value = currentTheme.value;
    notifyListeners();
  }

  Future<void> onChangeTheme(ThemeMode mode) async {
    themeSelected.value = mode;
    await _themeService.change(themeSelected.value);
    notifyListeners();
  }
}
