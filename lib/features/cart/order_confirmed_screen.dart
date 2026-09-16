import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/widgets/auth_submit_button.dart';
import 'package:slanh_pet_application/features/clinic_detail/widgets/success/success_booking.dart';
import 'package:slanh_pet_application/features/market_screen/market_screen.dart';
import 'package:slanh_pet_application/features/order_booking/order_booking.dart';

import 'models/order_summary.dart';

class OrderConfirmedScreen extends StatelessWidget {
  const OrderConfirmedScreen({super.key, required this.summary});

  final OrderSummary summary;

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
              const Text(
                'Order Placed!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your order has been placed successfully.',
                textAlign: TextAlign.center,
                style: TextStyle(
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
                    DetailRow(label: 'Items', value: summary.itemsLabel),
                    DetailRow(
                      label: 'Payment Method',
                      value: summary.paymentMethodLabel,
                    ),
                    DetailRow(
                      label: 'Delivery Address',
                      value: summary.deliveryAddress,
                    ),
                    DetailRow(
                      label: 'Total Paid',
                      value: summary.formattedTotal,
                    ),
                    DetailRow(
                      label: 'Order Ref',
                      value: summary.orderRef,
                      isLast: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              Row(
                children: [
                  Expanded(child: _buildViewOrdersButton(context)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildBackToMarketButton(context)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildViewOrdersButton(BuildContext context) {
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
          'View Orders',
          style: TextStyle(
            color: AppColors.orange,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildBackToMarketButton(BuildContext context) {
    return AuthSubmitButton(
      label: 'Back to Market',
      isSubmitting: false,
      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MarketScreen()),
        (route) => false,
      ),
    );
  }
}
