import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:slanh_pet_application/features/product_detail_screens/models/shop_model.dart';

class ShopService {
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _shops =>
      _firestore.collection('shops');

  /// Fetches a single shop by its document ID (the owner's uid).
  /// Returns null when the ID is empty or no such document exists.
  Future<Shop?> getShop(String id) async {
    if (id.isEmpty) return null;
    final snapshot = await _shops.doc(id).get();
    final data = snapshot.data();
    if (data == null) return null;
    return Shop.fromJson(data, snapshot.id);
  }
}
