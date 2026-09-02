import 'package:flutter/material.dart';
import 'package:slanh_pet_application/features/services/service.dart';

class AdoptBanner extends StatelessWidget {
  const AdoptBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServiceScreen()),
        ),
      },
      child: Container(
        height: 125,
        width: double.infinity,

        margin: EdgeInsets.all(20),

        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(25),

          child: Image.asset("assets/images/adoptPet.jpg", fit: BoxFit.cover),
        ),
      ),
    );
  }
}
