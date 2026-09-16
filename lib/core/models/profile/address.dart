import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  const AddressModel({
    required this.id,
    required this.label,
    required this.fullName,
    required this.phoneNumber,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.postcode,
    required this.state,
    required this.country,
    required this.createdAt,
    this.isDefault = false,
  });

  factory AddressModel.fromDocument(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    return AddressModel(
      id: document.id,
      label: data['label'] as String? ?? 'Address',
      fullName: data['fullName'] as String? ?? '',
      phoneNumber: data['phoneNumber'] as String? ?? '',
      addressLine1: data['addressLine1'] as String? ?? '',
      addressLine2: data['addressLine2'] as String? ?? '',
      city: data['city'] as String? ?? '',
      postcode: data['postcode'] as String? ?? '',
      state: data['state'] as String? ?? '',
      country: data['country'] as String? ?? '',
      createdAt:
          (data['createdAt'] as Timestamp?)?.toDate() ??
          DateTime.fromMillisecondsSinceEpoch(0),
      isDefault: data['isDefault'] as bool? ?? false,
    );
  }

  final String id;
  final String label;
  final String fullName;
  final String phoneNumber;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String postcode;
  final String state;
  final String country;
  final DateTime createdAt;
  final bool isDefault;

  String get formattedAddress => [
    addressLine1,
    addressLine2,
    '$city, $postcode',
    state,
  ].where((part) => part.trim().isNotEmpty).join(', ');
}
