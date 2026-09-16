import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../models/orders/delivery_address.dart';
import '../../models/orders/payment_method.dart';
import '../../state/cart_store.dart';

/// Persists a product order and deducts stock in one Firestore transaction.
class ProductOrderService {
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;
  FirebaseAuth get _auth => FirebaseAuth.instance;

  static const collectionName = 'product_orders';
  static const _requestTimeout = Duration(seconds: 15);

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
    final createdAt = FieldValue.serverTimestamp();
    final quantitiesByProduct = <String, int>{};

    for (final item in items) {
      final productId = item.productId;
      if (productId == null || productId.isEmpty) {
        throw const ProductUnavailableException(
          'This product is no longer available. Remove it from your cart and try again.',
        );
      }
      quantitiesByProduct.update(
        productId,
        (quantity) => quantity + item.quantity,
        ifAbsent: () => item.quantity,
      );
    }

    final orderData = <String, dynamic>{
      'userId': uid,
      'items': items
          .map(
            (item) => {
              'name': item.name,
              'price': item.price,
              'quantity': item.quantity,
              if (item.shopId != null) 'shopId': item.shopId,
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
      'createdAt': createdAt,
    };

    final itemsByShop = <String, List<CartProduct>>{};
    for (final item in items) {
      final shopId = item.shopId;
      if (shopId != null && shopId.isNotEmpty) {
        itemsByShop.putIfAbsent(shopId, () => []).add(item);
      }
    }
    final shopOrders = itemsByShop.entries
        .map(
          (entry) => <String, dynamic>{
            'shopId': entry.key,
            'orderId': docRef.id,
            'orderRef': orderRef,
            'customerName': deliveryAddress.name,
            'items': entry.value
                .map(
                  (item) => {
                    'name': item.name,
                    'price': item.price,
                    'quantity': item.quantity,
                  },
                )
                .toList(),
            'status': 'pending',
            'createdAt': createdAt,
          },
        )
        .toList();

    try {
      await _firestore
          .runTransaction((transaction) async {
            // Firestore requires every transaction read to happen before writes.
            final productSnapshots =
                <String, DocumentSnapshot<Map<String, dynamic>>>{};
            for (final productId in quantitiesByProduct.keys) {
              productSnapshots[productId] = await transaction.get(
                _firestore.collection('products').doc(productId),
              );
            }

            for (final entry in quantitiesByProduct.entries) {
              final snapshot = productSnapshots[entry.key]!;
              final stock = (snapshot.data()?['stock'] as num?)?.toInt();
              if (!snapshot.exists || stock == null || stock < entry.value) {
                throw ProductUnavailableException(
                  '"${snapshot.data()?['name'] ?? 'A product'}" no longer has enough stock.',
                );
              }
            }

            transaction.set(docRef, orderData);
            for (final shopOrder in shopOrders) {
              transaction.set(
                _firestore.collection('shop_orders').doc(),
                shopOrder,
              );
            }
            for (final entry in quantitiesByProduct.entries) {
              transaction.update(
                _firestore.collection('products').doc(entry.key),
                {'stock': FieldValue.increment(-entry.value)},
              );
            }
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

class ProductUnavailableException implements Exception {
  const ProductUnavailableException(this.message);

  final String message;

  @override
  String toString() => message;
}
