import 'package:cloud_firestore/cloud_firestore.dart';

/// One-time sample data for the `clinics` and `services` collections, keyed
/// by fixed doc IDs so re-running this is safe — it overwrites the same
/// documents instead of creating duplicates.
Future<void> seedSampleServiceLocations() async {
  final firestore = FirebaseFirestore.instance;
  final batch = firestore.batch();

  const clinics = {
    'sample-clinic-1': {
      'name': 'PawCare Clinic BKK1',
      'address': 'Street 51, BKK1, Phnom Penh',
      'lat': 11.5480,
      'long': 104.9270,
      'picture': 'https://placehold.co/200x200?text=PawCare',
    },
    'sample-clinic-2': {
      'name': 'Happy Tails Vet Toul Kork',
      'address': 'Street 289, Toul Kork, Phnom Penh',
      'lat': 11.5730,
      'long': 104.8930,
      'picture': 'https://placehold.co/200x200?text=Happy+Tails',
    },
    'sample-clinic-3': {
      'name': 'Chroy Changvar Animal Hospital',
      'address': 'National Road 6, Chroy Changvar, Phnom Penh',
      'lat': 11.5850,
      'long': 104.9250,
      'picture': 'https://placehold.co/200x200?text=Chroy+Changvar',
    },
    'sample-clinic-4': {
      'name': 'VetFirst Clinic Chamkarmon',
      'address': 'Street 302, Chamkarmon, Phnom Penh',
      'lat': 11.5470,
      'long': 104.9180,
      'picture': 'https://placehold.co/200x200?text=VetFirst',
    },
  };

  const services = {
    'sample-service-1': {
      'name': 'Mekong Riverside Grooming',
      'address': 'Sisowath Quay, Phnom Penh',
      'lat': 11.5694,
      'long': 104.9282,
      'picture': 'https://placehold.co/200x200?text=Grooming',
    },
    'sample-service-2': {
      'name': 'Cozy Pet Hotel Sen Sok',
      'address': 'Street 1019, Sen Sok, Phnom Penh',
      'lat': 11.5950,
      'long': 104.8850,
      'picture': 'https://placehold.co/200x200?text=Pet+Hotel',
    },
  };

  clinics.forEach((id, data) {
    batch.set(firestore.collection('clinics').doc(id), data);
  });
  services.forEach((id, data) {
    batch.set(firestore.collection('services').doc(id), data);
  });

  await batch.commit();
}
