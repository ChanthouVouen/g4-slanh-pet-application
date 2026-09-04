import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getCollection(
    String collectionName,
  ) {
    return _firestore
        .collection(collectionName)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }
}
