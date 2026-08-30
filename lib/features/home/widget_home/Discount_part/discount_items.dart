import 'package:flutter/material.dart';

class DiscountItems extends StatelessWidget {
  final String imageUrl;

  const DiscountItems({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.orange,
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        child: Image.asset(
          imageUrl,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),

      // width: ,
      // height: double.infinity,
    );
  }
}
