import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/models/booking.dart';

class PriceBreakdown extends StatefulWidget {
  const PriceBreakdown({
    super.key,
    required this.serviceFee,
    required this.bookingFee,
    required this.totalPrice,
  });
  final double serviceFee;
  final double bookingFee;
  final double totalPrice;

  @override
  State<PriceBreakdown> createState() => _PriceBreakdownState();
}

class _PriceBreakdownState extends State<PriceBreakdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildPriceRow('Service', widget.serviceFee),
          const SizedBox(height: 8),
          _buildPriceRow('Booking Fee', widget.bookingFee),
          const Divider(height: 20, thickness: 0.5),
          _buildPriceRow('Total', widget.totalPrice, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? Colors.black : AppColors.textSecondary,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 14 : 13,
          ),
        ),
        Text(
          formatPrice(amount),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isTotal ? 15 : 13,
            color: isTotal ? AppColors.primary : Colors.black,
          ),
        ),
      ],
    );
  }
}
