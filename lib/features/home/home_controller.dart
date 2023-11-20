import 'package:flutter/foundation.dart';
import 'package:password_manager/core/interface/ipassword_service.dart';
import 'package:password_manager/core/model/document_firestore_model.dart';
import 'package:password_manager/core/model/password_model.dart';
import 'package:password_manager/core/service/password_service.dart';

class HomeController {
  final IPasswordService _passwordService = PasswordService();
  ValueNotifier<List<DocumentFirestoreModel<PasswordModel>>>
      passwordListNotifier = ValueNotifier([]);

  ValueNotifier<List<DocumentFirestoreModel<PasswordModel>>>
      passwordFilteredListNotifier = ValueNotifier([]);

  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);

  String searchFilter = '';

  String passwordCopiedId = '';

  Future<void> getAllPassword() async {
    try {
      isLoadingNotifier.value = true;
      passwordListNotifier.value = await _passwordService.getAll();
      applyFilter();
    } catch (_) {
      passwordListNotifier.value = [];
    } finally {
      isLoadingNotifier.value = false;
    }
  }

  void applyFilter() {
    var list = passwordListNotifier.value
        .where((element) =>
            searchFilter.isEmpty ||
            element.document.name
                .toUpperCase()
                .contains(searchFilter.toUpperCase()))
        .toList();
    list.sort((a, b) => b.document.createdAt.compareTo(a.document.createdAt));
    passwordFilteredListNotifier.value = list;
  }
}
