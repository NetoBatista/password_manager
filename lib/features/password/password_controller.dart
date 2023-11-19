import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/model/password_model.dart';

class PasswordController {
  var showPasswordNotifier = ValueNotifier<bool>(false);
  var isLoadingNotifier = ValueNotifier<bool>(false);
  var alertMessageNotifier = ValueNotifier<String>('');

  Future<void> submit(PasswordModel passwordModel) async {
    try {} catch (error) {
      alertMessageNotifier.value = 'error_default'.i18n();
    }
  }
}
