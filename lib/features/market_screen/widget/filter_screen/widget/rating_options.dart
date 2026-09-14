import 'package:flutter/material.dart';

class RatingOptions extends StatelessWidget {
  final List<String> ratings;
  final String selectedRating;

  final Color orange;
  final Color greyText;
  final Color lightBorder;

  final ValueChanged<String> onSelected;

  const RatingOptions({
    super.key,
    required this.ratings,
    required this.selectedRating,
    required this.orange,
    required this.greyText,
    required this.lightBorder,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ratings.map((rating) {
        final isSelected = selectedRating == rating;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                onSelected(rating);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 54,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? orange.withValues(alpha: 0.08)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? orange : lightBorder,
                    width: isSelected ? 2 : 1.5,
                  ),
                ),
                child: Text(
                  rating,
                  style: TextStyle(
                    color: isSelected ? orange : greyText,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
