import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:slanh_pet_application/features/services/models/service_model.dart';

class BookingService {
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;
  FirebaseAuth get _auth => FirebaseAuth.instance;

  static const collectionName = 'service_booking';
  static const _requestTimeout = Duration(seconds: 15);

  Future<String?> createBooking({
    required ServiceModel service,
    required DateTime date,
    required String time,
    required double servicePrice,
    required double bookingFee,
    required double total,
    required String bookingRef,
    String? notes,
  }) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;

    final docRef = _firestore.collection(collectionName).doc();

    try {
      await docRef
          .set({
            'userId': uid,
            'clinicId': service.clinicId,
            'clinicName': service.clinic.name,
            'clinicAddress': service.clinic.address,
            'serviceId': service.id,
            'serviceName': service.name,
            'servicePrice': servicePrice,
            'bookingFee': bookingFee,
            'totalPrice': total,
            'date': Timestamp.fromDate(
              DateTime(date.year, date.month, date.day),
            ),
            'time': time,
            'notes': notes?.trim() ?? '',
            'bookingRef': bookingRef,
            'status': 'pending',
            'createdAt': FieldValue.serverTimestamp(),
          })
          .timeout(_requestTimeout);
    } catch (e) {
      debugPrint('BookingService.createBooking: failed to save booking: $e');
      rethrow;
    }

    return docRef.id;
  }

  Stream<List<Map<String, dynamic>>> watchMyBookings() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Stream.empty();

    return _firestore
        .collection(collectionName)
        .where('userId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => {'id': doc.id, ...doc.data()})
              .toList(),
        );
  }
}
