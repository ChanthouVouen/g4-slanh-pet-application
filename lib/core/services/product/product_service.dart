import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:slanh_pet_application/features/product_detail_screens/models/product_models.dart';

class ProductService {
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _products =>
      _firestore.collection('products');

  /// Streams every product in the `products` collection.
  Stream<List<Product>> streamProducts() {
    return _products.snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => Product.fromJson(doc.data(), doc.id))
          .toList(),
    );
  }

  /// Fetches a single product by its Firestore document ID.
  Future<Product?> getProduct(String id) async {
    final snapshot = await _products.doc(id).get();
    final data = snapshot.data();
    if (data == null) return null;
    return Product.fromJson(data, snapshot.id);
  }
}
