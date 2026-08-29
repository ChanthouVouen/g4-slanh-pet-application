// import 'dart:math';

import 'package:flutter/material.dart';

class ContentsCommunity extends StatelessWidget {
  final String picture;
  final String title;
  final String username;
  final int like;
  const ContentsCommunity({
    super.key,
    required this.picture,
    required this.title,
    required this.username,
    required this.like,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        // border: Border.all(color: Colors.black),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 5,
            color: Colors.black12,
            spreadRadius: 1,
          ),
        ],
      ),

      width: 190,

      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.asset(
                picture,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 10, bottom: 10, right: 10),
            height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      username,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.red, size: 13),

                        Padding(
                          padding: EdgeInsetsGeometry.only(right: 10),
                          child: Text(
                            "${like}",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
