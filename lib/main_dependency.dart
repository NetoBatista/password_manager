import 'package:flutter/material.dart';
import 'package:password_manager/core/model/document_firestore_model.dart';
import 'package:password_manager/core/model/password_model.dart';
import 'package:password_manager/core/provider/dependency_provider.dart';
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

class MainDependency {
  static Map<String, WidgetBuilder> get mapRoutes {
    var settingsController = DependencyProvider.get<SettingsController>();
    var loginController = DependencyProvider.get<LoginController>();
    var homeController = DependencyProvider.get<HomeController>();
    var newAccountController = DependencyProvider.get<NewAccountController>();
    var passwordController = DependencyProvider.get<PasswordController>();
    var resetController = DependencyProvider.get<ResetPasswordController>();
    var removeAccountController =
        DependencyProvider.get<RemoveAccountController>();

    return <String, WidgetBuilder>{
      '/': (BuildContext context) {
        return LoginPage(
          controller: loginController,
          resetController: resetController,
        );
      },
      '/home': (BuildContext context) {
        return HomePage(controller: homeController);
      },
      '/new_account': (BuildContext context) {
        return NewAccountPage(
          controller: newAccountController,
        );
      },
      '/password': (BuildContext context) {
        var args = context.args() as DocumentFirestoreModel<PasswordModel>?;
        return PasswordPage(
          passwordModel: args,
          controller: passwordController,
        );
      },
      '/settings': (BuildContext context) {
        return SettingsPage(settingsController: settingsController);
      },
      '/know_more': (BuildContext context) {
        return const KnowMorePage();
      },
      '/privacy': (BuildContext context) {
        return const PrivacyPage();
      },
      '/remove_account': (BuildContext context) {
        return RemoveAccountPage(controller: removeAccountController);
      },
    };
  }
}
