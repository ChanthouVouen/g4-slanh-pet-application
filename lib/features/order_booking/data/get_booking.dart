import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/order_item_model.dart';

Future<List<OrderItemModel>> getBookingData() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return const [];
  }

  final serviceBookingSnapshot = await FirebaseFirestore.instance
      .collection('service_booking')
      .where('userId', isEqualTo: user.uid)
      .get();

  return serviceBookingSnapshot.docs
      .map((doc) => OrderItemModel.fromJson(doc.data()))
      .toList();
}
