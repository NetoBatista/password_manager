import 'package:auto_injector/auto_injector.dart';
import 'package:password_manager/core/interface/ifirebase_service.dart';
import 'package:password_manager/core/interface/ilocal_storage_service.dart';
import 'package:password_manager/core/interface/ipassword_service.dart';
import 'package:password_manager/core/interface/itheme_service.dart';
import 'package:password_manager/core/service/firebase_service.dart';
import 'package:password_manager/core/service/local_storage_service.dart';
import 'package:password_manager/core/service/password_service.dart';
import 'package:password_manager/core/service/theme_service.dart';

class DependencyProvider {
  static final _autoInjector = AutoInjector();
  static final _autoInjectorKeys = AutoInjector();

  static void injectDependency() {
    _inject<IFirebaseService>(FirebaseService.new);
    _inject<IPasswordService>(PasswordService.new);
    _inject<ILocalStorageService>(LocalStorageService.new);
    _inject<IThemeService>(ThemeService.new);
    _autoInjector.commit();
    _autoInjectorKeys.commit();
  }

  static void _inject<T>(Function func) {
    _autoInjector.addSingleton<T>(func);
    _autoInjectorKeys.addSingleton<T>(func, key: T.toString());
  }

  static T get<T extends Object>({String? key}) {
    if (key != null) {
      return _autoInjectorKeys.get<T>(key: key);
    }
    return _autoInjector.get<T>();
  }

  static void dispose() {
    _autoInjector.dispose();
    _autoInjectorKeys.dispose();
  }
}
