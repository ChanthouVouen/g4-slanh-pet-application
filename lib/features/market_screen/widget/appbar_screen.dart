import 'package:flutter/material.dart';
import 'package:slanh_pet_application/features/home/widget_home/SearchImplement_part/searching_page.dart';

class AppBarScreen extends StatelessWidget {
  const AppBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: 80,
      // color: Colors.blueAccent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              "Marketplace",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ),
          Row(
            spacing: 9,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchingPage()),
                  );
                },
                child: Container(
                  height: 40,
                  width: 40,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withValues(alpha: 0.2),
                  ),
                  child: Icon(Icons.search, color: Colors.black, size: 23),
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withValues(alpha: 0.2),
                    ),
                    child: const Icon(
                      Icons.add_shopping_cart,
                      color: Colors.black,
                      size: 23,
                    ),
                  ),

                  Positioned(
                    top: -7,
                    right: -6,
                    child: Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepOrange,
                      ),
                      child: const Text(
                        "3",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
