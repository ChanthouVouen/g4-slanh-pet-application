import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/widgets/auth_submit_button.dart';

class PlaceOrderBar extends StatelessWidget {
  const PlaceOrderBar({
    super.key,
    required this.total,
    required this.enabled,
    required this.isSubmitting,
    required this.onPressed,
  });

  final double total;
  final bool enabled;
  final bool isSubmitting;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: AuthSubmitButton(
          label: 'Place Order — \$${total.toStringAsFixed(2)}',
          enabled: enabled,
          isSubmitting: isSubmitting,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
