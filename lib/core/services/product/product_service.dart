import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:slanh_pet_application/core/models/commerce/product.dart';

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

  /// Streams every product owned by the given shop (seller), for the shop
  /// owner's own product-management screen.
  Stream<List<Product>> streamShopProducts(String shopId) {
    return _products
        .where('shopid', isEqualTo: shopId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Product.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  /// Creates a new product document, returning its generated ID.
  Future<String> createProduct(Product product) async {
    final docRef = await _products.add(product.toJson());
    return docRef.id;
  }

  Future<void> updateProduct(Product product) {
    return _products.doc(product.id).set(product.toJson());
  }

  Future<void> deleteProduct(String id) {
    return _products.doc(id).delete();
  }
}
