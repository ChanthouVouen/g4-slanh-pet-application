import 'package:flutter/material.dart';
import 'package:slanh_pet_application/features/home/widget_home/QuickService_part/contents_quickservices.dart';
import 'package:slanh_pet_application/features/services/service.dart';

// import 'package:flutter/rendering.dart';

class QuickservicePart extends StatelessWidget {
  const QuickservicePart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(20),
      width: double.infinity,
      // color: Colors.amber,
      height: 170,

      child: Column(
        children: [
          Container(
            // color: Colors.white,
            padding: EdgeInsets.all(20),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quick Services",
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
            width: double.infinity,

            height: 100,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 20),
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 18,
                children: [
                  ContentsQuickservices(picture: "🩺", title: "Vet"),
                  ContentsQuickservices(picture: "✂️", title: "Grooming"),

                  ContentsQuickservices(picture: "🎓", title: "Training"),
                  ContentsQuickservices(picture: "🏥", title: "Boarding"),
                  ContentsQuickservices(picture: "+", title: "More"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
