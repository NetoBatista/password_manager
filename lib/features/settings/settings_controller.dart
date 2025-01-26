import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/core/interface/ifirebase_service.dart';
import 'package:password_manager/core/interface/ilocal_storage_service.dart';
import 'package:password_manager/core/provider/dependency_provider.dart';
import 'package:password_manager/extension/translate_extension.dart';
import 'package:password_manager/extension/navigation_extension.dart';
import 'package:password_manager/shared/default_state_shared.dart';

class SettingsController extends ValueNotifier<IDefaultStateShared> {
  SettingsController() : super(DefaultStateShared());

  final IFirebaseService _firebaseService = DependencyProvider.get();
  final ILocalStorageService _localStorageService = DependencyProvider.get();

  void init() {
    value.error = '';
    value.isLoading = false;
    notifyListeners();
  }

  User getCurrentCredential() => _firebaseService.getCurrentUser();

  Future<void> changeAccount(BuildContext context) async {
    await _localStorageService.clear();
    if (!context.mounted) {
      return;
    }
    context.pushNamedAndRemoveUntil('/');
  }

  bool canChangePassword() {
    var user = getCurrentCredential();
    var isProviderPassword = user.providerData.any(
      (x) => x.email == user.email && x.providerId == "password",
    );
    return isProviderPassword;
  }

  String emailUserAuthenticated() {
    var user = getCurrentCredential();
    if (user.email == null || user.email!.isEmpty) {
      return 'no_account'.translate();
    }
    return user.email!;
  }
}
