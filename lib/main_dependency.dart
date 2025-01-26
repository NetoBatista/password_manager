import 'package:flutter/material.dart';
import 'package:password_manager/core/model/document_firestore_model.dart';
import 'package:password_manager/core/model/password_model.dart';
import 'package:password_manager/extension/navigation_extension.dart';
import 'package:password_manager/features/home/home_controller.dart';
import 'package:password_manager/features/home/home_page.dart';
import 'package:password_manager/features/know_more/know_more_page.dart';
import 'package:password_manager/features/login/login_controller.dart';
import 'package:password_manager/features/login/login_page.dart';
import 'package:password_manager/features/new_account/new_account_controller.dart';
import 'package:password_manager/features/new_account/new_account_page.dart';
import 'package:password_manager/features/password/password_controller.dart';
import 'package:password_manager/features/password/password_page.dart';
import 'package:password_manager/features/privacy/privacy_page.dart';
import 'package:password_manager/features/remove_account/remove_account_controller.dart';
import 'package:password_manager/features/remove_account/remove_account_page.dart';
import 'package:password_manager/features/reset_password/reset_password_controller.dart';
import 'package:password_manager/features/settings/settings_controller.dart';
import 'package:password_manager/features/settings/settings_page.dart';
import 'package:password_manager/features/theme/theme_controller.dart';
import 'package:password_manager/features/theme/theme_page.dart';
import 'package:password_manager/features/update_password/update_password_controller.dart';
import 'package:password_manager/features/update_password/update_password_page.dart';
import 'package:provider/provider.dart';

class MainDependency {
  static List<ChangeNotifierProvider> providers() {
    var loginController = ChangeNotifierProvider(
      create: (_) => LoginController(),
    );
    var homeController = ChangeNotifierProvider(
      create: (_) => HomeController(),
    );
    var newAccountController = ChangeNotifierProvider(
      create: (_) => NewAccountController(),
    );
    var passwordController = ChangeNotifierProvider(
      create: (_) => PasswordController(),
    );
    var settingsController = ChangeNotifierProvider(
      create: (_) => SettingsController(),
    );
    var removeAccountController = ChangeNotifierProvider(
      create: (_) => RemoveAccountController(),
    );
    var resetPasswordController = ChangeNotifierProvider(
      create: (_) => ResetPasswordController(),
    );
    var themeController = ChangeNotifierProvider(
      create: (_) => ThemeController(),
    );
    var updatePasswordController = ChangeNotifierProvider(
      create: (_) => UpdatePasswordController(),
    );
    return [
      loginController,
      homeController,
      newAccountController,
      passwordController,
      settingsController,
      removeAccountController,
      resetPasswordController,
      themeController,
      updatePasswordController,
    ];
  }

  static Map<String, WidgetBuilder> mapRoutes() {
    return <String, WidgetBuilder>{
      '/': (BuildContext context) {
        return const LoginPage();
      },
      '/home': (BuildContext context) {
        return const HomePage();
      },
      '/new_account': (BuildContext context) {
        return const NewAccountPage();
      },
      '/password': (BuildContext context) {
        var args = context.args() as DocumentFirestoreModel<PasswordModel>?;
        return PasswordPage(passwordModel: args);
      },
      '/settings': (BuildContext context) {
        return const SettingsPage();
      },
      '/know_more': (BuildContext context) {
        return const KnowMorePage();
      },
      '/privacy': (BuildContext context) {
        return const PrivacyPage();
      },
      '/remove_account': (BuildContext context) {
        return const RemoveAccountPage();
      },
      '/theme': (BuildContext context) {
        return const ThemePage();
      },
      '/change_password': (BuildContext context) {
        return const UpdatePasswordPage();
      },
    };
  }
}
