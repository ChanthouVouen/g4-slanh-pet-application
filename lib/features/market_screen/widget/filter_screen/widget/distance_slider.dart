import 'package:flutter/material.dart';

class DistanceSlider extends StatelessWidget {
  final double distance;

  final Color orange;
  final Color greyText;
  final Color darkText;

  final ValueChanged<double> onChanged;

  const DistanceSlider({
    super.key,
    required this.distance,
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
              "Distance",
              style: TextStyle(
                color: darkText,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(width: 6),

            Text(
              "${distance.round()} km",
              style: TextStyle(color: greyText, fontSize: 17),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Slider(
          min: 1,
          max: 50,
          value: distance,
          activeColor: orange,
          inactiveColor: Colors.grey.shade700,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
