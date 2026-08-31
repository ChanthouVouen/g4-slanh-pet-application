import 'package:flutter/material.dart';

class PriceRange extends StatelessWidget {
  final RangeValues priceRange;

  final Color orange;
  final Color greyText;
  final Color darkText;

  final ValueChanged<RangeValues> onChanged;

  const PriceRange({
    super.key,
    required this.priceRange,
    required this.orange,
    required this.greyText,
    required this.darkText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Price Range",
              style: TextStyle(
                color: darkText,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(width: 6),

            Text(
              "\$ ${priceRange.start.round()} - \$ ${priceRange.end.round()}",
              style: TextStyle(color: greyText, fontSize: 17),
            ),
          ],
        ),

        const SizedBox(height: 12),

        RangeSlider(
          min: 0,
          max: 328,
          divisions: 328,
          values: priceRange,
          activeColor: orange,
          inactiveColor: Colors.grey.shade700,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
