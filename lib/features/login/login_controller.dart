import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/constant/local_storage_constant.dart';
import 'package:password_manager/core/constant/type_auth_constant.dart';
import 'package:password_manager/core/interface/ifirebase_service.dart';
import 'package:password_manager/core/interface/ilocal_storage_service.dart';
import 'package:password_manager/core/model/account_model.dart';
import 'package:password_manager/core/service/firebase_service.dart';
import 'package:password_manager/core/service/local_storage_service.dart';
import 'package:password_manager/extension/navigation_extension.dart';

class LoginController {
  final IFirebaseService _firebaseService = FirebaseService();

  final ILocalStorageService _localStorageService = LocalStorageService();

  final messageAlertNotifier = ValueNotifier('');

  final isLoadingNotifier = ValueNotifier(false);

  Future<void> automaticLogin(BuildContext context) async {
    try {
      messageAlertNotifier.value = '';
      isLoadingNotifier.value = true;
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
      messageAlertNotifier.value = "error_default".i18n();
    } finally {
      isLoadingNotifier.value = false;
    }
  }

  Future<void> loginUserPassword(
    BuildContext context,
    AccountModel accountModel,
  ) async {
    try {
      messageAlertNotifier.value = '';
      isLoadingNotifier.value = true;

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
      messageAlertNotifier.value = code.toLowerCase().i18n();
    } catch (error) {
      messageAlertNotifier.value = "error_default".i18n();
    } finally {
      isLoadingNotifier.value = false;
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      messageAlertNotifier.value = '';
      isLoadingNotifier.value = true;

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
      messageAlertNotifier.value = "error_default".i18n();
    } finally {
      isLoadingNotifier.value = false;
    }
  }

  Future<void> loginAnonymously(BuildContext context) async {
    try {
      messageAlertNotifier.value = '';
      isLoadingNotifier.value = true;
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
      messageAlertNotifier.value = "error_default".i18n();
    } finally {
      isLoadingNotifier.value = false;
    }
  }
}
