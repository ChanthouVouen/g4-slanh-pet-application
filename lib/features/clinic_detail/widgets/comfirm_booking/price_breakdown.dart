import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/features/clinic_detail/models/booking_model.dart';

class PriceBreakdown extends StatefulWidget {
  const PriceBreakdown({
    super.key,
    required this._bookingFee,
    required this._totalPrice,
  });
  final double _bookingFee;
  final double _totalPrice;

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
          _buildPriceRow('Service', widget._totalPrice),
          const SizedBox(height: 8),
          _buildPriceRow('Booking Fee', widget._bookingFee),
          const Divider(height: 20, thickness: 0.5),
          _buildPriceRow(
            'Total',
            widget._bookingFee + widget._totalPrice,
            isTotal: true,
          ),
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
