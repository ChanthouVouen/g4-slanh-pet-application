import 'package:flutter/material.dart';
import 'package:slanh_pet_application/features/home/widget_home/Community_part/contents_community.dart';
import 'package:slanh_pet_application/features/services/service.dart';

// import 'package:flutter/rendering.dart';

class CommunityPart extends StatelessWidget {
  const CommunityPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      // color: Colors.amber,
      height: 280,

      child: Column(
        children: [
          Container(
            // color: Colors.white,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Community",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ServiceScreen()),
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

          Container(
            height: 200,
            width: double.infinity,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 20),
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 250,
                child: Row(
                  spacing: 18,
                  children: [
                    ContentsCommunity(
                      picture: "assets/images/dog1.jpg",
                      title: "Luna's Grooming",
                      username: "@Hakim",
                      like: 30,
                    ),
                    ContentsCommunity(
                      picture: "assets/images/bird1.jpg",
                      title: "First Vet Visit",
                      username: "@Neou",
                      like: 90,
                    ),

                    ContentsCommunity(
                      picture: "assets/images/onboarding_shop.jpg",
                      title: "Bunny Play Time",
                      username: "@Sok",
                      like: 134,
                    ),
                    ContentsCommunity(
                      picture: "assets/images/dog2.jpg",
                      title: "My cutie Dog",
                      username: "@Heng",
                      like: 1000,
                    ),
                    ContentsCommunity(
                      picture: "assets/images/cat1.jpg",
                      title: "I love my dog",
                      username: "@Veasna",
                      like: 300,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
