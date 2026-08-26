import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> getCollectionData() async {
  CollectionReference collectionRef = FirebaseFirestore.instance.collection(
    'services',
  );

  QuerySnapshot querySnapshot = await collectionRef.get();

  final allData = querySnapshot.docs
      .map((doc) => doc.data() as Map<String, dynamic>)
      .toList();

  return allData;
}
