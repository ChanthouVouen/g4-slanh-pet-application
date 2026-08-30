import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

import '../models/service_location.dart';

class ServiceLocationRepository {
  ServiceLocationRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<List<ServiceLocation>> watchAll() {
    return _firestore
        .collection('clinics')
        .snapshots()
        .map((snapshot) => _parse(snapshot));
  }

  List<ServiceLocation> _parse(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs
        .map((doc) => _fromDoc(doc))
        .whereType<ServiceLocation>()
        .toList();
  }

  ServiceLocation? _fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    final name = data['name'] as String?;
    final lat = (data['lat'] as num?)?.toDouble();
    final long = (data['long'] as num?)?.toDouble();
    if (name == null || lat == null || long == null) return null;

    return ServiceLocation(
      id: doc.id,
      name: name,
      address: data['address'] as String? ?? '',
      imageUrl: data['picture'] as String?,
      position: LatLng(lat, long),
    );
  }
}
