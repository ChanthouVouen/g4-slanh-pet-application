// import 'dart:math';

import 'package:flutter/material.dart';

class ContentsShopbyPart extends StatelessWidget {
  final String picture;
  final String title;
  const ContentsShopbyPart({
    super.key,
    required this.picture,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 255, 249, 249),
        // border: Border.all(color: Colors.black),
        boxShadow: [
          BoxShadow(
            blurRadius: 9,
            color: Colors.black12,
            spreadRadius: 1,
            offset: const Offset(1, 1),
          ),
        ],
      ),

      width: 100,

      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.only(top: 17),
            child: Text(picture, style: TextStyle(fontSize: 32)),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
