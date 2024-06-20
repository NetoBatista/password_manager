class DocumentFirestoreModel<T> {
  String id;
  T document;
  DocumentFirestoreModel({
    required this.id,
    required this.document,
  });
}
