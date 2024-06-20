import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password_manager/core/interface/ifirebase_service.dart';
import 'package:password_manager/core/interface/ipassword_service.dart';
import 'package:password_manager/core/model/document_firestore_model.dart';
import 'package:password_manager/core/model/password_model.dart';
import 'package:password_manager/core/service/firebase_service.dart';

class PasswordService implements IPasswordService {
  final IFirebaseService _firebaseService;
  PasswordService(this._firebaseService);

  CollectionReference<Map<String, dynamic>> get _collectionReference {
    var currentUser = _firebaseService.getCurrentUser();
    return FirebaseFirestore.instance.collection(currentUser.uid);
  }

  @override
  Future<DocumentFirestoreModel<PasswordModel>> create(
    PasswordModel passwordModel,
  ) async {
    var response = await _collectionReference.add(passwordModel.toMap());
    return DocumentFirestoreModel(id: response.id, document: passwordModel);
  }

  @override
  Future<List<DocumentFirestoreModel<PasswordModel>>> getAll() async {
    var response = await _collectionReference.get();

    if (response.docs.isNotEmpty) {
      return response.docs
          .map(
            (e) => DocumentFirestoreModel(
              id: e.id,
              document: PasswordModel.fromMap(e.data()),
            ),
          )
          .toList();
    }
    return [];
  }

  @override
  Future<void> remove(String id) async {
    var collection = await _collectionReference
        .where(
          FieldPath.documentId,
          isEqualTo: id,
        )
        .get();
    for (var doc in collection.docs) {
      await doc.reference.delete();
    }
  }

  @override
  Future<void> update(
    DocumentFirestoreModel<PasswordModel> passwordModel,
  ) async {
    return _collectionReference.doc(passwordModel.id).update(
      {
        'name': passwordModel.document.name,
        'password': passwordModel.document.password,
      },
    );
  }

  @override
  Future<void> removeAll() async {
    var response = await _collectionReference.get();
    for (var doc in response.docs) {
      await doc.reference.delete();
    }
  }
}
