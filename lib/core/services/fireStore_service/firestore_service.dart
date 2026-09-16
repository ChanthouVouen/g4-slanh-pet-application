import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getCollection(
    String collectionName,
  ) {
    return _firestore
        .collection(collectionName)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  // Get products by type
  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getProductsByType(
    String type,
  ) {
    return _firestore.collection('products').snapshots().map((snapshot) {
      if (type.trim().toLowerCase() == 'all') {
        return snapshot.docs;
      }
      final selectedType = type.trim().toLowerCase();

      return snapshot.docs.where((product) {
        final data = product.data();

        final productType = data['type']?.toString().trim().toLowerCase();

        return productType == selectedType;
      }).toList();
    });
  }

  // Search products by name or type
  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> searchProducts(
    String searchQuery,
  ) {
    return _firestore.collection('products').snapshots().map((snapshot) {
      final query = searchQuery.trim().toLowerCase();

      if (query.isEmpty) {
        return snapshot.docs;
      }

      return snapshot.docs.where((product) {
        final data = product.data();

        final name = data['name']?.toString().trim().toLowerCase() ?? '';
        final type = data['type']?.toString().trim().toLowerCase() ?? '';

        return name.contains(query) || type.contains(query);
      }).toList();
    });
  }
}
