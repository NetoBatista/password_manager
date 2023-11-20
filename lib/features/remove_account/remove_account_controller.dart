import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/interface/ifirebase_service.dart';
import 'package:password_manager/core/interface/ilocal_storage_service.dart';
import 'package:password_manager/core/interface/ipassword_service.dart';
import 'package:password_manager/core/service/firebase_service.dart';
import 'package:password_manager/core/service/local_storage_service.dart';
import 'package:password_manager/core/service/password_service.dart';
import 'package:password_manager/extension/navigation_extension.dart';

class RemoveAccountController {
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  final IFirebaseService _firebaseService = FirebaseService();
  final IPasswordService _passwordService = PasswordService();
  final ILocalStorageService _localStorageService = LocalStorageService();
  ValueNotifier<String> messageAlertNotifier = ValueNotifier('');

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
