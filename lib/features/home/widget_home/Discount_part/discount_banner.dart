import 'dart:async';

import 'package:flutter/material.dart';
import 'package:slanh_pet_application/features/home/widget_home/Discount_part/discount_items.dart';
import 'package:slanh_pet_application/features/services/service.dart';

class DiscountBanner extends StatefulWidget {
  const DiscountBanner({super.key});

  @override
  State<DiscountBanner> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<DiscountBanner> {
  final PageController pageController = PageController();

  Timer? timer;

  final List<Map<String, String>> banners = [
    {'image': 'assets/images/onboarding_partner.jpg'},
    {'image': 'assets/images/onboarding_shop.jpg'},
    {'image': 'assets/images/onboarding_care.jpg'},

    // duplicate of 1 pic
    {'image': 'assets/images/onboarding_partner.jpg'},
  ];

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!pageController.hasClients) {
        return;
      }

      final currentPage = pageController.page!.round();

      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      if (currentPage == banners.length - 2) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (pageController.hasClients) {
            pageController.jumpToPage(0);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceScreen(),
          ), //will change to it MarketScreen when it done
        );
      },
      child: SizedBox(
        height: 230,
        child: PageView.builder(
          controller: pageController,
          itemCount: banners.length,
          itemBuilder: (context, index) {
            final banner = banners[index];

            return Padding(
              padding: const EdgeInsets.all(20),

              child: DiscountItems(imageUrl: banner['image']!),
            );
          },
        ),
      ),
    );
  }
}
