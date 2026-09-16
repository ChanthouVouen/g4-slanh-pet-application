import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/orders/order_item.dart';

/// Loads the signed-in user's service bookings and product orders together.
class OrderHistoryService {
  OrderHistoryService({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  /// Returns the newest order first.
  Future<List<OrderItemModel>> fetchCurrentUserOrders() async {
    final user = _auth.currentUser;
    if (user == null) return const [];

    final serviceBookingSnapshot = await _firestore
        .collection('service_booking')
        .where('userId', isEqualTo: user.uid)
        .get();

    final productOrderSnapshot = await _firestore
        .collection('product_orders')
        .where('userId', isEqualTo: user.uid)
        .get();

    final orders = [
      ...serviceBookingSnapshot.docs.map(
        (doc) => OrderItemModel.fromJson(doc.data()),
      ),
      ...productOrderSnapshot.docs.map(
        (doc) => OrderItemModel.fromProductOrder(doc.data()),
      ),
    ];

    orders.sort((a, b) => b.date.compareTo(a.date));

    return orders;
  }
}
