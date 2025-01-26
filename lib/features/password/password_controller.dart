import 'package:flutter/material.dart';
import 'package:password_manager/core/enum/password_strength_enum.dart';
import 'package:password_manager/core/interface/ipassword_service.dart';
import 'package:password_manager/core/model/document_firestore_model.dart';
import 'package:password_manager/core/model/password_model.dart';
import 'package:password_manager/core/provider/dependency_provider.dart';
import 'package:password_manager/core/util/password_util.dart';
import 'package:password_manager/extension/navigation_extension.dart';
import 'package:password_manager/extension/translate_extension.dart';
import 'package:password_manager/shared/default_state_shared.dart';

class PasswordController extends ValueNotifier<IDefaultStateShared> {
  PasswordController() : super(DefaultStateShared());

  final IPasswordService _passwordService = DependencyProvider.get();
  PasswordStrengthEnum passwordStrength = PasswordStrengthEnum.none;
  bool showPassword = false;

  void init() {
    value.error = '';
    value.isLoading = false;
    notifyListeners();
  }

  void validateSecurityPassword(String input) {
    var passwordStrenght = PasswordUtil.validatePasswordStrength(input);
    passwordStrength = passwordStrenght;
    notifyListeners();
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  Future<void> submit(
    BuildContext context,
    DocumentFirestoreModel<PasswordModel> passwordModel,
  ) async {
    try {
      value.error = '';
      value.isLoading = true;
      notifyListeners();

      if (passwordModel.id.isEmpty) {
        passwordModel = await _passwordService.create(passwordModel.document);
      } else {
        await _passwordService.update(passwordModel);
      }

      if (!context.mounted) {
        return;
      }
      context.pop();
    } catch (error) {
      value.error = 'error_default'.translate();
    } finally {
      value.isLoading = false;
      notifyListeners();
    }
  }

  Future<void> remove(
    BuildContext context,
    DocumentFirestoreModel<PasswordModel> passwordModel,
  ) async {
    try {
      value.error = '';
      value.isLoading = true;
      notifyListeners();

      await _passwordService.remove(passwordModel.id);
      if (!context.mounted) {
        return;
      }
      context.pop();
    } catch (error) {
      value.error = 'error_default'.translate();
    } finally {
      value.isLoading = false;
      notifyListeners();
    }
  }
}
