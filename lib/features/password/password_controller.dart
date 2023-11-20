import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/interface/ipassword_service.dart';
import 'package:password_manager/core/model/document_firestore_model.dart';
import 'package:password_manager/core/model/password_model.dart';
import 'package:password_manager/core/service/password_service.dart';
import 'package:password_manager/extension/navigation_extension.dart';

class PasswordController {
  var showPasswordNotifier = ValueNotifier<bool>(false);
  var isLoadingNotifier = ValueNotifier<bool>(false);
  var alertMessageNotifier = ValueNotifier<String>('');
  final IPasswordService _passwordService = PasswordService();

  Future<void> submit(
    BuildContext context,
    DocumentFirestoreModel<PasswordModel> passwordModel,
  ) async {
    try {
      isLoadingNotifier.value = true;

      if (passwordModel.id.isEmpty) {
        passwordModel = await _passwordService.create(passwordModel.document);
      } else {
        await _passwordService.update(passwordModel);
      }

      if (!context.mounted) {
        return;
      }
      passwordModel.updated = true;
      context.pop(result: passwordModel);
    } catch (error) {
      alertMessageNotifier.value = 'error_default'.i18n();
    } finally {
      isLoadingNotifier.value = false;
    }
  }

  Future<void> remove(
    BuildContext context,
    DocumentFirestoreModel<PasswordModel> passwordModel,
  ) async {
    try {
      isLoadingNotifier.value = true;
      await _passwordService.remove(passwordModel.id);

      if (!context.mounted) {
        return;
      }

      passwordModel.removed = true;
      context.pop(result: passwordModel);
    } catch (error) {
      alertMessageNotifier.value = 'error_default'.i18n();
    } finally {
      isLoadingNotifier.value = false;
    }
  }
}
