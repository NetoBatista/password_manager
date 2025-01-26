import 'package:flutter/foundation.dart';
import 'package:password_manager/core/interface/ipassword_service.dart';
import 'package:password_manager/core/model/document_firestore_model.dart';
import 'package:password_manager/core/model/password_model.dart';
import 'package:password_manager/core/provider/dependency_provider.dart';
import 'package:password_manager/shared/default_state_shared.dart';

class HomeController extends ValueNotifier<IDefaultStateShared> {
  HomeController() : super(DefaultStateShared());

  final IPasswordService _passwordService = DependencyProvider.get();
  List<DocumentFirestoreModel<PasswordModel>> _passwordList = [];

  String _searchFilter = '';

  Future<void> getAllPassword() async {
    try {
      value.isLoading = true;
      notifyListeners();
      _passwordList = await _passwordService.getAll();
    } catch (_) {
      _passwordList = [];
    } finally {
      value.isLoading = false;
      notifyListeners();
    }
  }

  void setFilter(String value) {
    _searchFilter = value;
    notifyListeners();
  }

  List<DocumentFirestoreModel<PasswordModel>> getPasswordList() {
    var list = _passwordList.where((
      DocumentFirestoreModel<PasswordModel> element,
    ) {
      if (_searchFilter.isEmpty) {
        return true;
      }
      return element.document.name
          .toUpperCase()
          .contains(_searchFilter.toUpperCase());
    }).toList();
    list.sort((a, b) => b.document.createdAt.compareTo(a.document.createdAt));
    return list;
  }
}
