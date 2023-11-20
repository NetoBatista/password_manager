import 'package:password_manager/core/model/document_firestore_model.dart';
import 'package:password_manager/core/model/password_model.dart';

abstract class IPasswordService {
  Future<DocumentFirestoreModel<PasswordModel>> create(
    PasswordModel passwordModel,
  );

  Future<List<DocumentFirestoreModel<PasswordModel>>> getAll();

  Future<void> update(DocumentFirestoreModel<PasswordModel> passwordModel);

  Future<void> remove(String id);

  Future<void> removeAll();
}
