import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slanh_pet_application/features/home/widget_home/SearchImplement_part/searching_page.dart';
import 'package:slanh_pet_application/features/home/widget_home/data_users/user_name.dart';

// import 'package:slanh_pet_application/main.dart';

class SearchImplement extends StatelessWidget {
  const SearchImplement({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 195,
      color: Color.fromARGB(255, 247, 127, 90),
      child: Column(
        children: [
          SizedBox(height: 30),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.all(15),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back🙏🏻",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    UserName(),
                  ],
                ),
                Container(
                  child: Row(
                    children: [
                      // IconButton(onPressed: onPressed, icon: icon),
                      // IconButton(onPressed: onPressed, icon: icon),
                      Container(
                        height: 35,
                        width: 35,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                        child: Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                        child: Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchingPage()),
              );
            },
            child: Container(
              width: 385,
              height: 45,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 10),
                    child: Icon(Icons.search, color: Colors.white),
                  ),
                  Container(
                    child: Text(
                      "Search pet, products, services...",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.white, size: 15),
                      Text(
                        "Petaling Jaya, MY",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  " 📦2 orders in transit",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
