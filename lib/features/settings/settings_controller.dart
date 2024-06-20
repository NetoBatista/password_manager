import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/constant/local_storage_constant.dart';
import 'package:password_manager/core/interface/ifirebase_service.dart';
import 'package:password_manager/core/interface/ilocal_storage_service.dart';
import 'package:password_manager/core/interface/itheme_service.dart';
import 'package:password_manager/extension/navigation_extension.dart';

class SettingsController {
  var changePasswordNotifier = ValueNotifier<bool>(false);
  var isLoadingNotifier = ValueNotifier<bool>(false);
  var messageAlertNotifier = ValueNotifier('');
  final IFirebaseService _firebaseService;
  final ILocalStorageService _localStorageService;
  final IThemeService _themeService;

  SettingsController(
    this._themeService,
    this._firebaseService,
    this._localStorageService,
  );

  User getCurrentCredential() => _firebaseService.getCurrentUser();
  ValueNotifier<ThemeMode> getCurrentTheme() => _themeService.getCurrent();
  ValueNotifier<ThemeMode> themeSelected = ValueNotifier(ThemeMode.system);

  void loadCurrentTheme() {
    var currentTheme = getCurrentTheme();
    themeSelected.value = currentTheme.value;
  }

  Future<void> changeAccount(BuildContext context) async {
    await _localStorageService.clear();
    if (!context.mounted) {
      return;
    }
    context.pushNamedAndRemoveUntil('/');
  }

  bool canChangePassword() {
    var user = getCurrentCredential();
    var isProviderPassword = user.providerData.any(
      (x) => x.email == user.email && x.providerId == "password",
    );
    return isProviderPassword;
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      messageAlertNotifier.value = '';
      isLoadingNotifier.value = true;
      var currentUser = getCurrentCredential();
      var response = await _firebaseService.signInWithEmailAndPassword(
        currentUser.email!,
        oldPassword,
      );
      if (response.user != null) {
        await _firebaseService.updatePassword(newPassword);
      }
      await _localStorageService.setString(
        LocalStorageConstant.password,
        newPassword,
      );
      messageAlertNotifier.value = "password_changed_successfully".i18n();
    } on FirebaseAuthException catch (error) {
      var code = error.code.replaceAll('-', '_');
      messageAlertNotifier.value = code.toLowerCase().i18n();
    } catch (error) {
      messageAlertNotifier.value = 'error_default'.i18n();
    } finally {
      isLoadingNotifier.value = false;
    }
  }

  String emailUserAuthenticated() {
    var user = getCurrentCredential();
    if (user.email == null || user.email!.isEmpty) {
      return 'no_account'.i18n();
    }
    return user.email!;
  }

  Future<void> onChangeTheme() {
    return _themeService.change(themeSelected.value);
  }
}
