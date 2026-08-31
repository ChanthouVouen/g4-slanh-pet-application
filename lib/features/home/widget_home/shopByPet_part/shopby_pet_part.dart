import 'package:flutter/material.dart';
// import 'package:slanh_pet_application/features/home/widget_home/QuickService_part/contents_quickservices.dart';
import 'package:slanh_pet_application/features/home/widget_home/shopByPet_part/contents_shopby_part.dart';
import 'package:slanh_pet_application/features/market_screen/market_screen.dart';
import 'package:slanh_pet_application/features/services/service.dart';

class ShopbyPetPart extends StatelessWidget {
  const ShopbyPetPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),

      width: double.infinity,
      // color: Colors.amber,
      height: 170,

      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shop by Pet",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MarketScreen()),
                    );
                  },

                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          "See all",
                          style: TextStyle(
                            color: Color.fromARGB(255, 247, 127, 90),
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Color.fromARGB(255, 247, 127, 90),
                          size: 19,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            // color: const Color.fromARGB(255, 250, 250, 250),
            width: double.infinity,
            height: 100,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 20),
              child: Row(
                spacing: 18,
                children: [
                  ContentsShopbyPart(picture: "🐶", title: "Dogs"),
                  ContentsShopbyPart(picture: "🐱", title: "Cats"),

                  ContentsShopbyPart(picture: "🐟", title: "Fish"),
                  ContentsShopbyPart(picture: "🐰", title: "Rabbits"),
                  ContentsShopbyPart(picture: "+", title: "More"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
