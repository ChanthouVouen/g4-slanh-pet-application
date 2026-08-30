import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/service_model.dart';

Future<List<ServiceModel>> getServiceData() async {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final QuerySnapshot servicesSnapshot = await db.collection('services').get();

  if (servicesSnapshot.docs.isEmpty) {
    return [];
  }

  final List<String> uniqueClinicIds = servicesSnapshot.docs
      .map(
        (doc) => (doc.data() as Map<String, dynamic>)['clinic_id'] as String?,
      )
      .whereType<String>()
      .toSet()
      .toList();

  Map<String, Map<String, dynamic>> clinicMap = {};

  if (uniqueClinicIds.isNotEmpty) {
    final clinicSnapshots = await Future.wait(
      uniqueClinicIds.map((id) => db.collection('clinics').doc(id).get()),
    );

    for (var doc in clinicSnapshots) {
      if (doc.exists) {
        clinicMap[doc.id] = {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }
    }
  }

  return servicesSnapshot.docs.map((doc) {
    Map<String, dynamic> serviceData = doc.data() as Map<String, dynamic>;
    String clinicId = serviceData['clinic_id'] ?? '';

    serviceData['id'] = doc.id;
    serviceData['clinic'] =
        clinicMap[clinicId] ?? {};

    return ServiceModel.fromMap(serviceData);
  }).toList();
}
