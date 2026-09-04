import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../models/profile_model.dart';

class ProfileRepository {
  ProfileRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<ProfileModel> watchProfile(User user) {
    return _firestore
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .map(
          (snapshot) => ProfileModel.fromMap(
            snapshot.data() ?? <String, dynamic>{},
            authEmail: user.email,
          ),
        );
  }

  Future<void> updateProfile({
    required String userId,
    required String name,
    required String phone,
    required String dateOfBirth,
    required String bio,
    required String gender,
  }) {
    return _firestore.collection('users').doc(userId).update({
      'fullName': name.trim(),
      'phone': phone.trim(),
      'dateOfBirth': dateOfBirth.trim(),
      'bio': bio.trim(),
      'gender': gender.trim(),
    });
  }

  Future<void> updateProfilePhoto({
    required String userId,
    required XFile image,
  }) async {
    final imageBytes = await image.readAsBytes();
    final imageRef = FirebaseStorage.instance.ref().child(
      'profile_photos/${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    await imageRef.putData(
      imageBytes,
      SettableMetadata(contentType: _contentType(image.name)),
    );
    final photoUrl = await imageRef.getDownloadURL();
    await _firestore.collection('users').doc(userId).set({
      'photoUrl': photoUrl,
    }, SetOptions(merge: true));
  }

  String _contentType(String fileName) {
    final extension = fileName.toLowerCase().split('.').last;
    return switch (extension) {
      'png' => 'image/png',
      'webp' => 'image/webp',
      'gif' => 'image/gif',
      _ => 'image/jpeg',
    };
  }
}
