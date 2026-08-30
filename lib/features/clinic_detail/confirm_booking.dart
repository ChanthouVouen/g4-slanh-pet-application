import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/navigation/bottom_nav_routes.dart';
import 'package:slanh_pet_application/core/widgets/auth_submit_button.dart';
import 'package:slanh_pet_application/core/widgets/circle_back_button.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';
import 'package:slanh_pet_application/features/clinic_detail/widgets/comfirm_booking/clinic_card_summary.dart';
import 'package:slanh_pet_application/features/clinic_detail/widgets/comfirm_booking/date_selection.dart';
import 'package:slanh_pet_application/features/clinic_detail/widgets/comfirm_booking/price_breakdown.dart';
import 'package:slanh_pet_application/features/clinic_detail/widgets/comfirm_booking/time_selection.dart';
import 'package:slanh_pet_application/features/services/models/service_model.dart';

import 'models/booking_model.dart';
import 'success_booking.dart';

const double _bookingFee = 2.0;

const int _daysAhead = 6;

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key, required this.service});

  /// The clinic/service this appointment is being booked with.
  final ServiceModel service;

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  static const int _tabIndex = 2;
  static const Color _background = Color(0xFFFBF3EE);

  static const List<String> _times = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
  ];

  late final List<DateOptionModel> _dates = List.generate(
    _daysAhead,
    (index) => DateOptionModel(DateTime.now().add(Duration(days: index))),
  );

  int _selectedDateIndex = 0;
  int _selectedTimeIndex = 0;
  final _notesController = TextEditingController();

  double get _servicePrice => widget.service.price;
  double get _total => _servicePrice + _bookingFee;

  static double _parsePrice(String priceFrom) {
    final match = RegExp(r'[\d.]+').firstMatch(priceFrom);
    return match == null ? 0 : double.tryParse(match.group(0)!) ?? 0;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _confirmBooking() {
    final summary = BookingSummary.create(
      clinicName: widget.service.name,
      date: _dates[_selectedDateIndex].date,
      time: _times[_selectedTimeIndex],
      total: _total,
      // total: 10,
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => BookingConfirmedScreen(summary: summary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleBackButton(),
        ),
        title: const Text(
          'Book Appointment',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClinicCardSummary(
              name: widget.service.clinic.name,
              picture: widget.service.clinic.picture,
              address: widget.service.clinic.address,
              price: widget.service.price,
            ),
            const SizedBox(height: 20),

            _buildSectionTitle('Select Date'),
            const SizedBox(height: 12),

            DateSelection(dates: _dates),
            const SizedBox(height: 24),

            _buildSectionTitle('Select Time'),
            const SizedBox(height: 12),

            TimeSelection(times: _times),
            const SizedBox(height: 24),

            _buildSectionTitle('Special Notes'),
            const SizedBox(height: 12),

            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Any special instructions or requirements...',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                fillColor: const Color(0xFFF5F5F5),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            PriceBreakdown(bookingFee: _bookingFee, totalPrice: _total),
            const SizedBox(height: 20),

            AuthSubmitButton(
              label: 'Confirm Booking',
              isSubmitting: false,
              onPressed: _confirmBooking,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _tabIndex,
        onTap: (index) =>
            switchBottomNavTab(context, currentIndex: _tabIndex, index: index),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
