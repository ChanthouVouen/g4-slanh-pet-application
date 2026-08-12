import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/register/register_string.dart';
import 'package:slanh_pet_application/core/widgets/customer_text_field.dart';

class ShopFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController addressController;

  const ShopFields({
    super.key,
    required this.nameController,
    required this.addressController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: RegisterString.shopNameLabel,
          hintText: RegisterString.shopNameHintText,
          controller: nameController,
        ),
        CustomTextField(
          label: RegisterString.shopAddressLabel,
          hintText: RegisterString.shopAddressHintText,
          controller: addressController,
        ),
      ],
    );
  }
}
