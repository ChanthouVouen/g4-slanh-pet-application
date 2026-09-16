import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/widgets/auth_submit_button.dart';
import 'package:slanh_pet_application/features/clinic_detail/widgets/success/success_booking.dart';
import 'package:slanh_pet_application/features/order_booking/order_booking.dart';
import 'package:slanh_pet_application/features/services/service.dart';

import 'models/booking_model.dart';

class BookingConfirmedScreen extends StatelessWidget {
  const BookingConfirmedScreen({super.key, required this.summary});

  final BookingSummary summary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // _buildHeader(),
              Text(
                'Booking Successful!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your appointment at ${summary.clinicName} has been booked successfully.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.labelGray,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.borderLight, width: 1.5),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    DetailRow(label: 'Clinic', value: summary.clinicName),
                    DetailRow(label: 'Service', value: summary.serviceName),
                    DetailRow(label: 'Date', value: summary.formattedDate),
                    DetailRow(label: 'Time', value: summary.time),
                    DetailRow(
                      label: 'Total Paid',
                      value: summary.formattedTotal,
                    ),
                    DetailRow(
                      label: 'Booking Ref',
                      value: summary.bookingRef,
                      isLast: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              Row(
                children: [
                  Expanded(child: _buildViewBookingButton(context)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildBackToServiceButton(context)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildViewBookingButton(BuildContext context) {
    return SizedBox(
      height: AuthSubmitButton.height,
      child: OutlinedButton(
        onPressed: () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const OrderBooking()),
          (route) => false,
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.orange, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'View Booking',
          style: TextStyle(
            color: AppColors.orange,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildBackToServiceButton(BuildContext context) {
    return AuthSubmitButton(
      label: 'Back to Service',
      isSubmitting: false,
      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const ServiceScreen()),
        (route) => false,
      ),
    );
  }
}
