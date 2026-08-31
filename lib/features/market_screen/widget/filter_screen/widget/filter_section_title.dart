import 'package:flutter/material.dart';

class FilterSectionTitle extends StatelessWidget {
  final String title;
  final Color darkText;

  const FilterSectionTitle({
    super.key,
    required this.title,
    required this.darkText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: darkText,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
