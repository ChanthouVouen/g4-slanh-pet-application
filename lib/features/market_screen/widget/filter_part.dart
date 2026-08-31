import 'package:flutter/material.dart';
import 'package:slanh_pet_application/features/market_screen/widget/filter_screen/filter_sort_screen.dart';

class FilterPart extends StatelessWidget {
  const FilterPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              "847 Products",
              style: TextStyle(color: const Color.fromARGB(255, 145, 145, 145)),
            ),
          ),
          Container(
            height: 25,

            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FilterSortScreen()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.filter_alt_outlined),
                  Text(
                    "Filter & Sort",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
