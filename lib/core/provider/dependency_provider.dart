import 'package:auto_injector/auto_injector.dart';
import 'package:password_manager/core/interface/itheme_service.dart';
import 'package:password_manager/core/service/theme_service.dart';
import 'package:password_manager/features/settings/settings_controller.dart';

class DependencyProvider {
  static final _autoInjector = AutoInjector();

  static void injectDependency() {
    _autoInjector.addSingleton<IThemeService>(ThemeService.new);
    _autoInjector.addSingleton(SettingsController.new);
    _autoInjector.commit();
  }

  static T get<T extends Object>() {
    return _autoInjector.get<T>();
  }
}
