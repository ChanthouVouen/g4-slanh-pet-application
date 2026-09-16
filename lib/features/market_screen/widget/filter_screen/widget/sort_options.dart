import 'package:flutter/material.dart';

class SortOptions extends StatelessWidget {
  final List<String> options;
  final String selectedOption;

  final Color orange;
  final Color greyText;
  final Color lightBorder;

  final ValueChanged<String> onSelected;

  const SortOptions({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.orange,
    required this.greyText,
    required this.lightBorder,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.7,
      ),
      itemBuilder: (context, index) {
        final option = options[index];

        final isSelected = selectedOption == option;

        return GestureDetector(
          onTap: () {
            onSelected(option);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? orange.withValues(alpha: 0.08) : Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: isSelected ? orange : lightBorder,
                width: isSelected ? 2 : 1.5,
              ),
            ),
            child: Text(
              option,
              style: TextStyle(
                color: isSelected ? orange : greyText,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }
}
