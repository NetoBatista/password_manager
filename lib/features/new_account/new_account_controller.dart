import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/model/new_account_model.dart';

class NewAccountController {
  var isLoadingNotifier = ValueNotifier<bool>(false);
  var alertMessageNotifier = ValueNotifier<String>('');

  Future<void> submit(NewAccountModel accountModel) async {
    try {} catch (error) {
      alertMessageNotifier.value = 'error_default'.i18n();
    }
  }
}
