class DocumentFirestoreModel<T> {
  String id;
  T document;
  bool updated = false;
  bool removed = false;
  DocumentFirestoreModel({
    required this.id,
    required this.document,
  });
}
