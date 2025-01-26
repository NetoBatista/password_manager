import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/core/constant/local_storage_constant.dart';
import 'package:password_manager/core/interface/ifirebase_service.dart';
import 'package:password_manager/core/interface/ilocal_storage_service.dart';
import 'package:password_manager/core/provider/dependency_provider.dart';
import 'package:password_manager/extension/translate_extension.dart';
import 'package:password_manager/shared/default_state_shared.dart';

class UpdatePasswordController extends ValueNotifier<IDefaultStateShared> {
  UpdatePasswordController() : super(DefaultStateShared());

  final IFirebaseService _firebaseService = DependencyProvider.get();
  final ILocalStorageService _localStorageService = DependencyProvider.get();

  void init() {
    value.error = '';
    value.isLoading = false;
    notifyListeners();
  }

  User getCurrentCredential() => _firebaseService.getCurrentUser();

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      value.error = '';
      value.isLoading = true;
      notifyListeners();

      var currentUser = getCurrentCredential();
      var response = await _firebaseService.signInWithEmailAndPassword(
        currentUser.email!,
        oldPassword,
      );
      if (response.user == null) {
        value.error = 'error_default'.translate();
        return;
      }
      await _firebaseService.updatePassword(newPassword);
      await _localStorageService.setString(
        LocalStorageConstant.password,
        newPassword,
      );
      value.error = "password_changed_successfully".translate();
    } on FirebaseAuthException catch (error) {
      var code = error.code.replaceAll('-', '_');
      value.error = code.toLowerCase().translate();
    } catch (error) {
      value.error = 'error_default'.translate();
    } finally {
      value.isLoading = false;
      notifyListeners();
    }
  }
}
