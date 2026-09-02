// import 'dart:math';

import 'package:flutter/material.dart';

class ContentsQuickservices extends StatelessWidget {
  final String picture;
  final String title;
  const ContentsQuickservices({
    super.key,
    required this.picture,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        // border: Border.all(color: Colors.black),
        boxShadow: [
          BoxShadow(offset: Offset(1, 1), blurRadius: 3, color: Colors.black12),
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
