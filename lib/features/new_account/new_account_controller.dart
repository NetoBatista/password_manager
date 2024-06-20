import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/constant/local_storage_constant.dart';
import 'package:password_manager/core/constant/type_auth_constant.dart';
import 'package:password_manager/core/interface/ifirebase_service.dart';
import 'package:password_manager/core/interface/ilocal_storage_service.dart';
import 'package:password_manager/core/model/account_model.dart';
import 'package:password_manager/extension/navigation_extension.dart';

class NewAccountController {
  final IFirebaseService _firebaseService;
  final ILocalStorageService _localStorageService;
  var isLoadingNotifier = ValueNotifier<bool>(false);
  var alertMessageNotifier = ValueNotifier<String>('');
  NewAccountController(
    this._firebaseService,
    this._localStorageService,
  );

  Future<void> submit(BuildContext context, AccountModel accountModel) async {
    try {
      alertMessageNotifier.value = '';
      isLoadingNotifier.value = true;
      var credential = await _firebaseService.createUserWithEmailAndPassword(
        accountModel.emailAddress,
        accountModel.password,
      );

      if (credential.user == null) {
        return;
      }

      await _localStorageService.setString(
        LocalStorageConstant.email,
        accountModel.emailAddress,
      );

      await _localStorageService.setString(
        LocalStorageConstant.typeAuth,
        TypeAuthConstant.emailPassword,
      );

      await _localStorageService.setString(
        LocalStorageConstant.password,
        accountModel.password,
      );

      if (!context.mounted) {
        return;
      }

      context.pushNamedAndRemoveUntil('/home');
    } catch (error) {
      alertMessageNotifier.value = 'error_default'.i18n();
    } finally {
      isLoadingNotifier.value = false;
    }
  }
}
