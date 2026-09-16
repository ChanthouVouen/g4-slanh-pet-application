import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/widgets/section_card.dart';
import 'package:slanh_pet_application/core/widgets/selectable_option_tile.dart';

import 'package:slanh_pet_application/core/models/orders/payment_method.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final PaymentMethod selected;
  final ValueChanged<PaymentMethod> onChanged;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      children: [
        const SectionHeader(Icons.payment_outlined, 'Payment Method'),
        const SizedBox(height: 12),
        SelectableOptionTile(
          icon: Icons.qr_code_2,
          label: 'KHQR Code',
          selected: selected == PaymentMethod.khqr,
          onTap: () => onChanged(PaymentMethod.khqr),
        ),
        const SizedBox(height: 10),
        SelectableOptionTile(
          icon: Icons.payments_outlined,
          label: 'Cash on Delivery',
          selected: selected == PaymentMethod.cashOnDelivery,
          onTap: () => onChanged(PaymentMethod.cashOnDelivery),
        ),
      ],
    );
  }
}
