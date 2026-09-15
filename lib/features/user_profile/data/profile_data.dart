import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
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
    if (kIsWeb) {
      await _updateProfilePhotoWeb(userId: userId, image: image);
      return;
    }
    final profileDir = await _getProfileImageDirectory();
    final ext = p.extension(image.name);
    final fileName = '${userId}_${DateTime.now().millisecondsSinceEpoch}$ext';
    final savedImage = await File(image.path).copy('${profileDir.path}/$fileName');
    await _firestore.collection('users').doc(userId).set({
      'photoUrl': savedImage.path,
    }, SetOptions(merge: true));
  }

  Future<void> _updateProfilePhotoWeb({
    required String userId,
    required XFile image,
  }) async {
    final bytes = await image.readAsBytes();
    final dataUrl = 'data:${_mimeType(image.name)};base64,${base64Encode(bytes)}';
    await _firestore.collection('users').doc(userId).set({
      'photoUrl': dataUrl,
    }, SetOptions(merge: true));
  }

  String _mimeType(String fileName) {
    final extension = fileName.toLowerCase().split('.').last;
    return switch (extension) {
      'png' => 'image/png',
      'webp' => 'image/webp',
      'gif' => 'image/gif',
      _ => 'image/jpeg',
    };
  }

  Future<Directory> _getProfileImageDirectory() async {
    Directory profileDir;
    try {
      final appDir = await getApplicationDocumentsDirectory();
      profileDir = Directory('${appDir.path}/profile_photos');
    } catch (_) {
      profileDir = Directory(
        '${Directory.current.path}/profile_photos',
      );
    }
    if (!await profileDir.exists()) {
      await profileDir.create(recursive: true);
    }
    return profileDir;
  }
}
