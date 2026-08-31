import 'package:flutter/material.dart';

class FeatureOptions extends StatelessWidget {
  final List<String> features;
  final Set<String> selectedFeatures;

  final Color orange;
  final Color darkText;
  final Color lightBorder;

  final ValueChanged<String> onChanged;

  const FeatureOptions({
    super.key,
    required this.features,
    required this.selectedFeatures,
    required this.orange,
    required this.darkText,
    required this.lightBorder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: lightBorder, width: 1),
      ),
      child: Column(
        children: features.asMap().entries.map((entry) {
          final index = entry.key;
          final feature = entry.value;

          final isSelected = selectedFeatures.contains(feature);

          return Column(
            children: [
              _FeatureRow(
                feature: feature,
                isSelected: isSelected,
                orange: orange,
                darkText: darkText,
                onChanged: onChanged,
              ),

              if (index != features.length - 1)
                Divider(height: 1, color: lightBorder),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final String feature;
  final bool isSelected;

  final Color orange;
  final Color darkText;

  final ValueChanged<String> onChanged;

  const _FeatureRow({
    required this.feature,
    required this.isSelected,
    required this.orange,
    required this.darkText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () {
        onChanged(feature);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? orange : Colors.white,
                border: Border.all(color: orange, width: 1),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : null,
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                feature,
                style: TextStyle(
                  color: darkText,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Icon(Icons.keyboard_arrow_down, color: darkText, size: 24),
          ],
        ),
      ),
    );
  }
}
