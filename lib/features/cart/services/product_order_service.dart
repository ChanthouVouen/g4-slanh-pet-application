import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../cart_store.dart';
import '../models/delivery_address.dart';
import '../models/payment_method.dart';

/// Persists a placed cart order to Firestore so it shows up in the user's
/// order list alongside their service bookings.
class ProductOrderService {
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;
  FirebaseAuth get _auth => FirebaseAuth.instance;

  static const collectionName = 'product_orders';
  static const _requestTimeout = Duration(seconds: 15);

  /// Returns the created order's human-readable reference, or null if no
  /// user is signed in. Throws if the write itself fails (e.g. Firestore
  /// rules reject it) so callers can tell the two cases apart.
  Future<String?> createOrder({
    required List<CartProduct> items,
    required double total,
    required PaymentMethod paymentMethod,
    required DeliveryAddress deliveryAddress,
  }) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;

    final docRef = _firestore.collection(collectionName).doc();
    final orderRef = _generateOrderRef();

    try {
      await docRef
          .set({
            'userId': uid,
            'items': items
                .map(
                  (item) => {
                    'name': item.name,
                    'price': item.price,
                    'quantity': item.quantity,
                  },
                )
                .toList(),
            'itemCount': items.length,
            'total': total,
            'paymentMethod': paymentMethod.name,
            'deliveryName': deliveryAddress.name,
            'deliveryPhone': deliveryAddress.phone,
            'deliveryAddress': deliveryAddress.address,
            'orderRef': orderRef,
            'status': 'pending',
            'createdAt': FieldValue.serverTimestamp(),
          })
          .timeout(_requestTimeout);
    } catch (e) {
      debugPrint('ProductOrderService.createOrder: failed to save order: $e');
      rethrow;
    }

    return orderRef;
  }

  static String _generateOrderRef() {
    final now = DateTime.now();
    return '#ORD-${now.year}${_pad(now.month)}${_pad(now.day)}-'
        '${now.millisecondsSinceEpoch % 1000}';
  }

  static String _pad(int n) => n.toString().padLeft(2, '0');
}
