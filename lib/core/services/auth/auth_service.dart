import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  FirebaseAuth get _auth => FirebaseAuth.instance;
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  static const _requestTimeout = Duration(seconds: 15);

  /// Registers a user using Firebase Auth, then best-effort saves profile
  /// metadata to Cloud Firestore. Returns "success" once the account exists —
  /// a failed or slow profile save does not block sign-up.
  Future<String?> signUpUser({
    required String email,
    required String password,
    required String role, // Expected values: 'customer' or 'seller'
    required Map<String, dynamic> extraFields,
    Map<String, dynamic>? shopFields,
  }) async {
    if (Firebase.apps.isEmpty) {
      return 'Account creation is not configured for this platform yet.';
    }

    final UserCredential userCredential;
    try {
      userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .timeout(_requestTimeout);
    } on FirebaseAuthException catch (e) {
      // Handle known Firebase edge-case authentication exceptions
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'An account already exists for that email address.';
      } else if (e.code == 'invalid-email') {
        return 'The email address format is invalid.';
      }
      final message = e.message;
      if (message != null && message.isNotEmpty && message != 'Error') {
        return message;
      }
      return _authErrorMessage(e.code);
    } on TimeoutException {
      return 'Could not reach the server. Please check your connection and try again.';
    } catch (e) {
      return e.toString();
    }

    // Keep the common account data in users/{uid}. Seller shop data belongs in
    // shops/{uid}, which makes it easy to fetch the shop from its owner ID.
    // A batch ensures the profile and shop are saved together.
    try {
      final uid = userCredential.user!.uid;
      final userData = {
        'uid': uid,
        'email': email,
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
        ...extraFields,
      };

      final batch = _firestore.batch()
        ..set(_firestore.collection('users').doc(uid), userData);

      if (role == 'seller' && shopFields != null) {
        batch.set(_firestore.collection('shops').doc(uid), {
          'ownerId': uid,
          'createdAt': FieldValue.serverTimestamp(),
          ...shopFields,
        });
      }

      await batch.commit().timeout(_requestTimeout);
    } on FirebaseException catch (e) {
      debugPrint('AuthService.signUpUser: failed to save profile/shop: $e');
      if (e.code == 'permission-denied') {
        return 'Firestore denied saving your profile. Please update the Firestore security rules.';
      }
      return e.message ??
          'Unable to save your profile (Firestore error: ${e.code}).';
    } on TimeoutException {
      return 'Your account was created, but saving the profile timed out. Please try again.';
    } catch (e) {
      debugPrint('AuthService.signUpUser: failed to save profile/shop: $e');
      return 'Your account was created, but the profile could not be saved.';
    }

    return 'success';
  }

  /// Signs in an existing account with Firebase email/password authentication.
  Future<String?> signInUser({
    required String email,
    required String password,
  }) async {
    if (Firebase.apps.isEmpty) {
      return 'Sign-in is not configured for this platform yet.';
    }

    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .timeout(_requestTimeout);
      return 'success';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
        case 'user-not-found':
        case 'wrong-password':
          return 'The email address or password is incorrect.';
        case 'user-disabled':
          return 'This account has been disabled.';
        case 'invalid-email':
          return 'The email address format is invalid.';
      }

      final message = e.message;
      if (message != null && message.isNotEmpty && message != 'Error') {
        return message;
      }
      return 'Unable to sign in (Firebase error: ${e.code}).';
    } on TimeoutException {
      return 'Could not reach the server. Please check your connection and try again.';
    } catch (e) {
      return 'Unable to sign in. Please try again.';
    }
  }

  String _authErrorMessage(String code) {
    switch (code) {
      case 'operation-not-allowed':
        return 'Email/password sign-in is disabled in Firebase Console.';
      case 'unauthorized-domain':
        return 'This website domain is not authorized in Firebase Console.';
      case 'network-request-failed':
        return 'Could not reach Firebase. Please check your internet connection.';
      default:
        return 'Unable to create the account (Firebase error: $code).';
    }
  }

  /// Retrieves the signed-in seller's shop document from shops/{uid}.
  Future<Map<String, dynamic>?> getSellerShop({String? sellerId}) async {
    if (Firebase.apps.isEmpty) return null;

    final uid = sellerId ?? _auth.currentUser?.uid;
    if (uid == null) return null;

    try {
      final snapshot = await _firestore
          .collection('shops')
          .doc(uid)
          .get()
          .timeout(_requestTimeout);

      return snapshot.data();
    } on TimeoutException {
      debugPrint('AuthService.getSellerShop: request timed out');
      return null;
    } catch (e) {
      debugPrint('AuthService.getSellerShop: failed to load shop: $e');
      return null;
    }
  }
}
