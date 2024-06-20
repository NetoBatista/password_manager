import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/interface/ifirebase_service.dart';

class ResetPasswordController {
  final IFirebaseService _firebaseService;
  var isLoadingNotifier = ValueNotifier<bool>(false);
  var alertMessageNotifier = ValueNotifier<String>('');

  ResetPasswordController(
    this._firebaseService,
  );

  Future<void> submit(String email) async {
    try {
      isLoadingNotifier.value = true;
      await _firebaseService.sendPasswordResetEmail(email);
      alertMessageNotifier.value = 'reset_password_success'.i18n();
    } catch (error) {
      alertMessageNotifier.value = 'error_default'.i18n();
    } finally {
      isLoadingNotifier.value = false;
    }
  }
}
