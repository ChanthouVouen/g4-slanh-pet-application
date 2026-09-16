import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/order_item_model.dart';

/// Loads the signed-in user's service bookings and product orders together,
/// newest first.
Future<List<OrderItemModel>> getBookingData() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return const [];
  }

  final firestore = FirebaseFirestore.instance;

  final serviceBookingSnapshot = await firestore
      .collection('service_booking')
      .where('userId', isEqualTo: user.uid)
      .get();

  final productOrderSnapshot = await firestore
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
