import 'package:auto_injector/auto_injector.dart';
import 'package:password_manager/core/interface/ifirebase_service.dart';
import 'package:password_manager/core/interface/ilocal_storage_service.dart';
import 'package:password_manager/core/interface/ipassword_service.dart';
import 'package:password_manager/core/interface/itheme_service.dart';
import 'package:password_manager/core/service/firebase_service.dart';
import 'package:password_manager/core/service/local_storage_service.dart';
import 'package:password_manager/core/service/password_service.dart';
import 'package:password_manager/core/service/theme_service.dart';
import 'package:password_manager/features/home/home_controller.dart';
import 'package:password_manager/features/login/login_controller.dart';
import 'package:password_manager/features/new_account/new_account_controller.dart';
import 'package:password_manager/features/password/password_controller.dart';
import 'package:password_manager/features/remove_account/remove_account_controller.dart';
import 'package:password_manager/features/reset_password/reset_password_controller.dart';
import 'package:password_manager/features/settings/settings_controller.dart';

class DependencyProvider {
  static final _autoInjector = AutoInjector();

  static void injectDependency() {
    _autoInjector.addSingleton<IThemeService>(ThemeService.new);
    _autoInjector.addSingleton<ILocalStorageService>(LocalStorageService.new);
    _autoInjector.addSingleton<IFirebaseService>(FirebaseService.new);
    _autoInjector.addSingleton<IPasswordService>(PasswordService.new);
    _autoInjector.addSingleton(PasswordController.new);
    _autoInjector.addSingleton(SettingsController.new);
    _autoInjector.addSingleton(LoginController.new);
    _autoInjector.addSingleton(HomeController.new);
    _autoInjector.addSingleton(NewAccountController.new);
    _autoInjector.addSingleton(RemoveAccountController.new);
    _autoInjector.addSingleton(ResetPasswordController.new);
    _autoInjector.commit();
  }

  static T get<T extends Object>() {
    return _autoInjector.get<T>();
  }

  static void dispose() {
    return _autoInjector.dispose();
  }
}
