import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/core/constant/local_storage_constant.dart';
import 'package:password_manager/core/constant/type_auth_constant.dart';
import 'package:password_manager/core/interface/ifirebase_service.dart';
import 'package:password_manager/core/interface/ilocal_storage_service.dart';
import 'package:password_manager/core/model/account_model.dart';
import 'package:password_manager/core/provider/dependency_provider.dart';
import 'package:password_manager/extension/navigation_extension.dart';
import 'package:password_manager/extension/translate_extension.dart';
import 'package:password_manager/shared/default_state_shared.dart';

class LoginController extends ValueNotifier<IDefaultStateShared> {
  LoginController() : super(DefaultStateShared());

  final IFirebaseService _firebaseService = DependencyProvider.get();
  final ILocalStorageService _localStorageService = DependencyProvider.get();

  Future<void> automaticLogin(BuildContext context) async {
    try {
      value.error = '';
      value.isLoading = true;
      notifyListeners();

      var email = await _localStorageService.getString(
        LocalStorageConstant.email,
      );

      var password = await _localStorageService.getString(
        LocalStorageConstant.password,
      );

      var typeAuth = await _localStorageService.getString(
        LocalStorageConstant.typeAuth,
      );

      if (typeAuth == null) {
        return;
      }

      UserCredential? credential;
      if (typeAuth == TypeAuthConstant.google) {
        var response = await _firebaseService.signInSilently();
        if (response == null) {
          return;
        }
        credential = await _firebaseService.signInWithCredential(response);
      } else if (typeAuth == TypeAuthConstant.emailPassword) {
        credential = await _firebaseService.signInWithEmailAndPassword(
          email!,
          password!,
        );
      } else {
        credential = await _firebaseService.signInAnonymously();
      }

      if (!context.mounted) {
        return;
      }

      if (credential.user == null) {
        return;
      }

      context.pushNamedAndRemoveUntil('/home');
    } catch (_) {
      value.error = "error_default".translate();
    } finally {
      value.isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginUserPassword(
    BuildContext context,
    AccountModel accountModel,
  ) async {
    try {
      value.error = '';
      value.isLoading = true;
      notifyListeners();

      var credential = await _firebaseService.signInWithEmailAndPassword(
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
    } on FirebaseAuthException catch (error) {
      var code = error.code.replaceAll('-', '_');
      value.error = code.toLowerCase().translate();
    } catch (error) {
      value.error = "error_default".translate();
    } finally {
      value.isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      value.error = '';
      value.isLoading = true;
      notifyListeners();

      await _firebaseService.signOut();

      var response = await _firebaseService.signIn();
      if (response == null) {
        return;
      }

      var credential = await _firebaseService.signInWithCredential(response);

      if (credential.user == null) {
        return;
      }

      await _localStorageService.setString(
        LocalStorageConstant.email,
        response.email,
      );

      await _localStorageService.setString(
        LocalStorageConstant.typeAuth,
        TypeAuthConstant.google,
      );

      if (!context.mounted) {
        return;
      }

      context.pushNamedAndRemoveUntil('/home');
    } catch (error) {
      value.error = "error_default".translate();
    } finally {
      value.isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginAnonymously(BuildContext context) async {
    try {
      value.error = '';
      value.isLoading = true;
      notifyListeners();

      var credential = await _firebaseService.signInAnonymously();

      if (credential.user == null) {
        return;
      }

      await _localStorageService.setString(
        LocalStorageConstant.typeAuth,
        TypeAuthConstant.anonymous,
      );

      if (!context.mounted) {
        return;
      }
      context.pushNamedAndRemoveUntil('/home');
    } catch (error) {
      value.error = "error_default".translate();
    } finally {
      value.isLoading = false;
      notifyListeners();
    }
  }
}
