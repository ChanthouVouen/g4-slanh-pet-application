import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';

class OrderItemModel {
  final String code;
  final String title;
  final String clinicName;
  final String clinicAddress;
  final DateTime date;
  final double price;
  final String status;
  final IconData icon;
  final String time;
  final Color iconColor;
  final Color iconBackground;

  const OrderItemModel({
    required this.code,
    required this.title,
    required this.clinicName,
    required this.clinicAddress,
    required this.date,
    required this.price,
    required this.status,
    required this.icon,
    required this.time,
    required this.iconColor,
    required this.iconBackground,
  });

  /// Builds an [OrderItemModel] from a `service_booking` Firestore document.
  factory OrderItemModel.fromJson(Map<String, dynamic> data) {
    final rawDate = data['date'];

    return OrderItemModel(
      code: (data['bookingRef'] as String?) ?? '',
      title: (data['serviceName'] as String?) ?? '',
      clinicName: (data['clinicName'] as String?) ?? '',
      clinicAddress: (data['clinicAddress'] as String?) ?? '',
      date: rawDate is Timestamp ? rawDate.toDate() : DateTime.now(),
      time: (data['time'] as String?) ?? '',
      price: ((data['totalPrice'] as num?) ?? 0).toDouble(),
      status: data['status'] as String? ?? 'pending',
      icon: Icons.medical_services_rounded,
      iconColor: AppColors.orange,
      iconBackground: const Color(0xFFFFE7DE),
    );
  }

  @override
  String toString() {
    return 'OrderItemModel(code: $code, title: $title, date: $date, '
        'price: $price, status: $status)';
  }
}
