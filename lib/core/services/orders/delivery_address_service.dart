import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/orders/delivery_address.dart';

/// Reads and writes the signed-in user's delivery address, stored on their
/// users/{uid} profile document alongside fullName/phone.
class DeliveryAddressService {
  FirebaseAuth get _auth => FirebaseAuth.instance;
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  Future<DeliveryAddress> fetchCurrent() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const DeliveryAddress();

    try {
      final snapshot = await _firestore.collection('users').doc(uid).get();
      final data = snapshot.data();
      if (data == null) return const DeliveryAddress();

      return DeliveryAddress(
        name: (data['fullName'] as String?) ?? '',
        phone: (data['phone'] as String?) ?? '',
        address: (data['address'] as String?) ?? '',
      );
    } catch (_) {
      return const DeliveryAddress();
    }
  }

  /// Best-effort save; the address still applies to the current order even
  /// if persisting it to the profile fails.
  Future<void> save(DeliveryAddress address) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    try {
      await _firestore.collection('users').doc(uid).set({
        'fullName': address.name,
        'phone': address.phone,
        'address': address.address,
      }, SetOptions(merge: true));
    } catch (_) {
      // Ignored — see doc comment above.
    }
  }
}
