import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/widgets/circle_back_button.dart';

class HeaderImageWidget extends StatelessWidget {
  const HeaderImageWidget({super.key, required this.picture});
  final String picture;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          picture,
          height: 280,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            height: 280,
            width: double.infinity,
            color: AppColors.inputBackground,
            child: const Icon(Icons.pets, size: 48, color: AppColors.labelGray),
          ),
        ),
        const Positioned(top: 48, left: 16, child: CircleBackButton()),
      ],
    );
  }
}
