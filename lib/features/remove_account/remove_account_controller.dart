import 'package:flutter/material.dart';
import 'package:password_manager/core/interface/ifirebase_service.dart';
import 'package:password_manager/core/interface/ilocal_storage_service.dart';
import 'package:password_manager/core/interface/ipassword_service.dart';
import 'package:password_manager/core/provider/dependency_provider.dart';
import 'package:password_manager/extension/navigation_extension.dart';
import 'package:password_manager/extension/translate_extension.dart';
import 'package:password_manager/shared/default_state_shared.dart';

class RemoveAccountController extends ValueNotifier<IDefaultStateShared> {
  RemoveAccountController() : super(DefaultStateShared());

  final IFirebaseService _firebaseService = DependencyProvider.get();
  final IPasswordService _passwordService = DependencyProvider.get();
  final ILocalStorageService _localStorageService = DependencyProvider.get();

  void init() {
    value.error = '';
    value.isLoading = false;
    notifyListeners();
  }

  Future<void> removeAccount(BuildContext context) async {
    try {
      value.error = '';
      value.isLoading = true;
      notifyListeners();

      await _passwordService.removeAll();
      await _firebaseService.deleteAccount();
      if (!context.mounted) {
        return;
      }
      _localStorageService.clear();
      context.pushNamedAndRemoveUntil('/');
    } catch (error) {
      value.error = 'error_default'.translate();
    } finally {
      value.isLoading = false;
      notifyListeners();
    }
  }
}
