import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/orders/shop_order.dart';

/// Reads the per-shop order records written by `ProductOrderService` at
/// checkout time. Each `shop_orders` document already contains only the
/// items and reference data for one shop, so a simple `shopId` equality
/// filter is all that's needed — and all a security rule needs to allow,
/// without granting a seller read access to other buyers' full orders.
class ShopOrderService {
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  Future<List<ShopOrder>> fetchOrdersForShop(String shopId) async {
    final snapshot = await _firestore
        .collection('shop_orders')
        .where('shopId', isEqualTo: shopId)
        .get();

    final orders = snapshot.docs.map((doc) {
      final data = doc.data();
      final rawItems = (data['items'] as List? ?? []).whereType<Map>();
      final rawDate = data['createdAt'];

      return ShopOrder(
        id: doc.id,
        orderRef: (data['orderRef'] as String?) ?? '',
        customerName: (data['customerName'] as String?) ?? 'Customer',
        createdAt: rawDate is Timestamp ? rawDate.toDate() : null,
        status: (data['status'] as String?) ?? 'pending',
        items: rawItems
            .map(
              (item) => ShopOrderItem(
                name: (item['name'] as String?) ?? '',
                price: (item['price'] as num?)?.toDouble() ?? 0,
                quantity: (item['quantity'] as num?)?.toInt() ?? 1,
              ),
            )
            .toList(),
      );
    }).toList();

    orders.sort((a, b) {
      final aDate = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bDate = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bDate.compareTo(aDate);
    });

    return orders;
  }
}
