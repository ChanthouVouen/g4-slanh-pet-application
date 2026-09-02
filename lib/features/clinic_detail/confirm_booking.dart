import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/navigation/bottom_nav_routes.dart';
import 'package:slanh_pet_application/core/services/booking/booking_service.dart';
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
  int _selectedTimeIndex = -1;
  final _notesController = TextEditingController();
  final _bookingService = BookingService();
  bool _isSubmitting = false;

  double get _servicePrice => widget.service.price;
  double get _total => _servicePrice + _bookingFee;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _confirmBooking() async {
    if (_isSubmitting) return;

    if (_selectedTimeIndex < 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a time.')));
      return;
    }

    setState(() => _isSubmitting = true);

    final date = _dates[_selectedDateIndex].date;
    final time = _times[_selectedTimeIndex];
    final summary = BookingSummary.create(
      clinicName: widget.service.clinic.name,
      serviceName: widget.service.name,
      date: date,
      time: time,
      total: _total,
    );

    try {
      final bookingId = await _bookingService.createBooking(
        service: widget.service,
        date: date,
        time: time,
        servicePrice: _servicePrice,
        bookingFee: _bookingFee,
        total: _total,
        bookingRef: summary.bookingRef,
        notes: _notesController.text,
      );

      if (!mounted) return;

      if (bookingId == null) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please sign in to book an appointment.'),
          ),
        );
        return;
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => BookingConfirmedScreen(summary: summary),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not save your booking. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Positioned(top: 100, left: 16, child: CircleBackButton()),
            const SizedBox(height: 20),

            ClinicCardSummary(
              name: widget.service.clinic.name,
              picture: widget.service.clinic.picture,
              address: widget.service.clinic.address,
              price: widget.service.price,
            ),
            const SizedBox(height: 20),

            _buildSectionTitle('Select Date'),
            const SizedBox(height: 12),

            DateSelection(
              dates: _dates,
              selectedIndex: _selectedDateIndex,
              onSelected: (index) => setState(() => _selectedDateIndex = index),
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Select Time'),
            const SizedBox(height: 12),

            TimeSelection(
              times: _times,
              selectedIndex: _selectedTimeIndex,
              onSelected: (index) => setState(() => _selectedTimeIndex = index),
            ),
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
              isSubmitting: _isSubmitting,
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
