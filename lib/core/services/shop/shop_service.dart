import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:slanh_pet_application/core/models/commerce/shop.dart';

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

  /// Streams the shop owned by the given uid, for the shop owner's own
  /// dashboard/settings screens.
  Stream<Shop?> watchShop(String id) {
    return _shops.doc(id).snapshots().map((snapshot) {
      final data = snapshot.data();
      if (data == null) return null;
      return Shop.fromJson(data, snapshot.id);
    });
  }

  Future<void> updateShop(Shop shop) {
    return _shops.doc(shop.id).set(shop.toUpdateMap(), SetOptions(merge: true));
  }
}
