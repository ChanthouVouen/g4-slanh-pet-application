import 'package:flutter/material.dart';

class FilterHeader extends StatelessWidget {
  final Color orange;
  final Color greyText;
  final Color darkText;
  final Color lightBorder;

  final VoidCallback onCancel;
  final VoidCallback onReset;

  const FilterHeader({
    super.key,
    required this.orange,
    required this.greyText,
    required this.darkText,
    required this.lightBorder,
    required this.onCancel,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: lightBorder, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: onCancel,
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: greyText,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          Text(
            "Filter & Sort",
            style: TextStyle(
              color: darkText,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),

          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onReset,
                child: Text(
                  "Reset",
                  style: TextStyle(
                    color: orange,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
