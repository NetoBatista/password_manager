import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/interface/ifirebase_service.dart';
import 'package:password_manager/core/interface/ilocal_storage_service.dart';
import 'package:password_manager/core/interface/ipassword_service.dart';
import 'package:password_manager/extension/navigation_extension.dart';

class RemoveAccountController {
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  ValueNotifier<String> messageAlertNotifier = ValueNotifier('');
  final IFirebaseService _firebaseService;
  final IPasswordService _passwordService;
  final ILocalStorageService _localStorageService;
  RemoveAccountController(
    this._localStorageService,
    this._firebaseService,
    this._passwordService,
  );

  Future<void> removeAccount(BuildContext context) async {
    try {
      isLoadingNotifier.value = true;
      await _passwordService.removeAll();
      await _firebaseService.deleteAccount();
      if (!context.mounted) {
        return;
      }
      _localStorageService.clear();
      context.pushNamedAndRemoveUntil('/');
    } catch (error) {
      messageAlertNotifier.value = 'error_default'.i18n();
    } finally {
      isLoadingNotifier.value = false;
    }
  }
}
