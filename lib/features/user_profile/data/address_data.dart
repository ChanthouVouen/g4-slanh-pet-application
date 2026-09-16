import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/address_model.dart';

class AddressRepository {
  AddressRepository({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CollectionReference<Map<String, dynamic>> get _collection {
    return _firestore.collection('addresses');
  }

  Stream<List<AddressModel>> watchAddresses() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value(const []);
    return _collection.where('userId', isEqualTo: user.uid).snapshots().map((
      snapshot,
    ) {
      final addresses = snapshot.docs.map(AddressModel.fromDocument).toList();
      addresses.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      return addresses;
    });
  }

  Future<void> addAddress({
    required String label,
    required String fullName,
    required String phoneNumber,
    required String addressLine1,
    required String addressLine2,
    required String city,
    required String postcode,
    required String state,
    required String country,
    required bool isDefault,
  }) async {
    final user = _requireUser();
    final collection = _collection;
    final existing = await collection
        .where('userId', isEqualTo: user.uid)
        .get();
    final shouldBeDefault = existing.docs.isEmpty || isDefault;
    final batch = _firestore.batch();
    if (shouldBeDefault) {
      for (final document in existing.docs) {
        batch.update(document.reference, {'isDefault': false});
      }
    }
    final document = collection.doc();
    batch.set(document, {
      'label': label,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'postcode': postcode,
      'state': state,
      'country': country,
      'userId': user.uid,
      'isDefault': shouldBeDefault,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    await batch.commit();
  }

  Future<void> updateAddress({
    required AddressModel address,
    required String label,
    required String fullName,
    required String phoneNumber,
    required String addressLine1,
    required String addressLine2,
    required String city,
    required String postcode,
    required String state,
    required String country,
  }) {
    final user = _requireUser();
    return _collection.doc(address.id).update({
      'label': label,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'postcode': postcode,
      'state': state,
      'country': country,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteAddress(AddressModel address) {
    final user = _requireUser();
    return _collection.doc(address.id).delete();
  }

  Future<void> setDefault(AddressModel selected) async {
    final user = _requireUser();
    final collection = _collection;
    final batch = _firestore.batch();
    for (final document
        in (await collection.where('userId', isEqualTo: user.uid).get()).docs) {
      batch.update(document.reference, {
        'isDefault': document.id == selected.id,
      });
    }
    await batch.commit();
  }

  User _requireUser() {
    final user = _auth.currentUser;
    if (user == null) throw StateError('Please sign in first');
    return user;
  }
}
