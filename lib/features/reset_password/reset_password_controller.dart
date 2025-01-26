import 'package:flutter/material.dart';
import 'package:password_manager/core/interface/ifirebase_service.dart';
import 'package:password_manager/core/provider/dependency_provider.dart';
import 'package:password_manager/extension/translate_extension.dart';
import 'package:password_manager/shared/default_state_shared.dart';

class ResetPasswordController extends ValueNotifier<IDefaultStateShared> {
  ResetPasswordController() : super(DefaultStateShared());

  final IFirebaseService _firebaseService = DependencyProvider.get();

  void init() {
    value.error = '';
    value.isLoading = false;
    notifyListeners();
  }

  Future<void> submit(String email) async {
    try {
      value.error = '';
      value.isLoading = true;
      notifyListeners();

      await _firebaseService.sendPasswordResetEmail(email);
      value.error = 'reset_password_success'.translate();
    } catch (error) {
      value.error = 'error_default'.translate();
    } finally {
      value.isLoading = false;
      notifyListeners();
    }
  }
}
