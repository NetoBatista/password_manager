import 'package:flutter/material.dart';
import 'package:password_manager/core/constant/local_storage_constant.dart';
import 'package:password_manager/core/constant/theme_mode_constant.dart';
import 'package:password_manager/core/interface/ilocal_storage_service.dart';
import 'package:password_manager/core/interface/itheme_service.dart';

class ThemeService implements IThemeService {
  final ILocalStorageService _localStorageService;
  final themeModeNotifier = ValueNotifier(ThemeMode.system);
  ThemeService(this._localStorageService) {
    init();
  }

  Future<void> init() async {
    var themeMode = await _localStorageService.getString(
      LocalStorageConstant.themeMode,
    );
    if (themeMode == null) {
      return;
    }
    if (themeMode == ThemeModeConstant.dark) {
      themeModeNotifier.value = ThemeMode.dark;
    }
    if (themeMode == ThemeModeConstant.light) {
      themeModeNotifier.value = ThemeMode.light;
    }
  }

  @override
  Future<void> change(ThemeMode theme) async {
    if (theme == ThemeMode.system) {
      await _localStorageService.remove(LocalStorageConstant.themeMode);
      themeModeNotifier.value = ThemeMode.system;
    }
    if (theme == ThemeMode.dark) {
      await _localStorageService.setString(
        LocalStorageConstant.themeMode,
        ThemeModeConstant.dark,
      );
      themeModeNotifier.value = ThemeMode.dark;
    }
    if (theme == ThemeMode.light) {
      await _localStorageService.setString(
        LocalStorageConstant.themeMode,
        ThemeModeConstant.light,
      );
      themeModeNotifier.value = ThemeMode.light;
    }
  }

  @override
  ValueNotifier<ThemeMode> getCurrent() => themeModeNotifier;
}
