import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/navigation/bottom_nav_routes.dart';
import 'package:slanh_pet_application/core/widgets/auth_submit_button.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';
import 'package:slanh_pet_application/core/widgets/status_pill.dart';
import 'package:slanh_pet_application/features/clinic_detail/widgets/clinic_detail/header_image.dart';
import 'package:slanh_pet_application/features/clinic_detail/widgets/clinic_detail/location_rating.dart';
import 'package:slanh_pet_application/features/services/models/service_model.dart';

import 'confirm_booking.dart';

class ClinicDetailsScreen extends StatelessWidget {
  const ClinicDetailsScreen({super.key, required this.service});

  final ServiceModel service;
  final isOpen = true;
  static const int _tabIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF3EE),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderImageWidget(picture: service.clinic.picture),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StatusPill(
                        label: isOpen ? 'Open Now' : 'Closed',
                        background: isOpen
                            ? const Color(0xFFDFF5E6)
                            : const Color(0xFFFCE4E1),
                        foreground: isOpen
                            ? const Color(0xFF1F9254)
                            : const Color(0xFFD32F2F),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        service.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      LocationRatingWidget(
                        rating: service.rating,
                        address: service.clinic.address,
                      ),
                      const SizedBox(height: 16),

                      Text(
                        "About this Service",
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 57, 56, 56),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Text(service.description),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: AuthSubmitButton(
              label: 'Book Appointment',
              isSubmitting: false,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BookAppointmentScreen(service: service),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _tabIndex,
        onTap: (index) =>
            switchBottomNavTab(context, currentIndex: _tabIndex, index: index),
      ),
    );
  }
}
