import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/widgets/auth_submit_button.dart';
import 'package:slanh_pet_application/features/services/service.dart';

import 'models/booking_model.dart';

class BookingConfirmedScreen extends StatelessWidget {
  const BookingConfirmedScreen({super.key, required this.summary});

  final BookingSummary summary;

  static const Color _background = Color(0xFFFFFDF9);
  static const Color _textDark = Color(0xFF1D2338);
  static const Color _borderLight = Color(0xFFE5E9F2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeader(),
              const SizedBox(height: 12),
              _buildSubtitle(),
              const SizedBox(height: 32),
              _buildDetailsCard(),
              const SizedBox(height: 36),
              _buildActions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Booking Confirmed!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: _textDark,
          ),
        ),
        SizedBox(width: 8),
        Text('🎉', style: TextStyle(fontSize: 24)),
      ],
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Your appointment at ${summary.clinicName} has been booked\n'
      'successfully.',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 15,
        color: AppColors.labelGray,
        height: 1.4,
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _borderLight, width: 1.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          _DetailRow(label: 'Clinic', value: summary.clinicName),
          _DetailRow(label: 'Date', value: summary.formattedDate),
          _DetailRow(label: 'Time', value: summary.time),
          _DetailRow(label: 'Total Paid', value: summary.formattedTotal),
          _DetailRow(
            label: 'Booking Ref',
            value: summary.bookingRef,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildViewBookingButton(context)),
        const SizedBox(width: 16),
        Expanded(child: _buildBackToServiceButton(context)),
      ],
    );
  }

  Widget _buildViewBookingButton(BuildContext context) {
    return SizedBox(
      height: AuthSubmitButton.height,
      child: OutlinedButton(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking details coming soon.')),
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

/// One label/value row in the booking details card.
class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.labelGray,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: BookingConfirmedScreen._textDark,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          const Divider(height: 1, thickness: 1, color: Color(0xFFF2F4F8)),
      ],
    );
  }
}
