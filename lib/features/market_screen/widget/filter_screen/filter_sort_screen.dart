import 'package:flutter/material.dart';
import 'package:slanh_pet_application/features/market_screen/widget/filter_screen/widget/apply_filter_button.dart';
import 'package:slanh_pet_application/features/market_screen/widget/filter_screen/widget/category_options.dart';
import 'package:slanh_pet_application/features/market_screen/widget/filter_screen/widget/distance_slider.dart';
import 'package:slanh_pet_application/features/market_screen/widget/filter_screen/widget/feature_options.dart';
import 'package:slanh_pet_application/features/market_screen/widget/filter_screen/widget/filter_header.dart';
import 'package:slanh_pet_application/features/market_screen/widget/filter_screen/widget/filter_section_title.dart';
import 'package:slanh_pet_application/features/market_screen/widget/filter_screen/widget/price_range.dart';
import 'package:slanh_pet_application/features/market_screen/widget/filter_screen/widget/rating_options.dart';
import 'package:slanh_pet_application/features/market_screen/widget/filter_screen/widget/sort_options.dart';

class FilterSortScreen extends StatefulWidget {
  const FilterSortScreen({super.key});

  @override
  State<FilterSortScreen> createState() => _FilterSortScreenState();
}

class _FilterSortScreenState extends State<FilterSortScreen> {
  // =========================
  // COLORS
  // =========================

  final Color orange = const Color(0xFFFF633D);
  final Color darkText = const Color(0xFF19182B);
  final Color greyText = const Color(0xFF9695A3);
  final Color lightBorder = const Color(0xFFE9E6E5);

  // =========================
  // SORT
  // =========================

  String selectedSort = "Relevance";

  final List<String> sortOptions = [
    "Relevance",
    "Price: Low-High",
    "Price: High-Low",
    "Rating",
    "Distance",
    "Newest",
  ];

  // =========================
  // CATEGORY
  // =========================

  String selectedCategory = "Dogs";

  final List<String> categories = [
    "Dogs",
    "Cats",
    "Rabbits",
    "Birds",
    "Fish",
    "Hamsters",
    "Reptiles",
    "Others",
  ];

  // =========================
  // PRICE
  // =========================

  RangeValues priceRange = const RangeValues(0, 328);

  // =========================
  // RATING
  // =========================

  String selectedRating = "4.5+";

  final List<String> ratings = ["4.5+", "4.0+", "3.5+", "Any"];

  // =========================
  // DISTANCE
  // =========================

  double distance = 5;

  // =========================
  // FEATURES
  // =========================

  final List<String> features = [
    "Free Delivery",
    "In Stock Only",
    "On Sale",
    "Top Rated",
    "Fast Shipping",
    "Trusted Seller",
  ];

  final Set<String> selectedFeatures = {"Free Delivery", "In Stock Only"};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            FilterHeader(
              orange: orange,
              greyText: greyText,
              darkText: darkText,
              lightBorder: lightBorder,
              onCancel: () {
                Navigator.pop(context);
              },
              onReset: _resetFilters,
            ),

            // CONTENT
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(26, 18, 26, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SORT
                    FilterSectionTitle(title: "Sort By", darkText: darkText),

                    const SizedBox(height: 18),

                    SortOptions(
                      options: sortOptions,
                      selectedOption: selectedSort,
                      orange: orange,
                      greyText: greyText,
                      lightBorder: lightBorder,
                      onSelected: (value) {
                        setState(() {
                          selectedSort = value;
                        });
                      },
                    ),

                    const SizedBox(height: 30),

                    // CATEGORY
                    FilterSectionTitle(
                      title: "Pet Category",
                      darkText: darkText,
                    ),

                    const SizedBox(height: 18),

                    CategoryOptions(
                      categories: categories,
                      selectedCategory: selectedCategory,
                      orange: orange,
                      greyText: greyText,
                      lightBorder: lightBorder,
                      onSelected: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                    ),

                    const SizedBox(height: 30),

                    // PRICE
                    PriceRange(
                      priceRange: priceRange,
                      orange: orange,
                      greyText: greyText,
                      darkText: darkText,
                      onChanged: (value) {
                        setState(() {
                          priceRange = value;
                        });
                      },
                    ),

                    const SizedBox(height: 30),

                    // RATING
                    FilterSectionTitle(title: "Rating", darkText: darkText),

                    const SizedBox(height: 18),

                    RatingOptions(
                      ratings: ratings,
                      selectedRating: selectedRating,
                      orange: orange,
                      greyText: greyText,
                      lightBorder: lightBorder,
                      onSelected: (value) {
                        setState(() {
                          selectedRating = value;
                        });
                      },
                    ),

                    const SizedBox(height: 30),

                    // DISTANCE
                    DistanceSlider(
                      distance: distance,
                      orange: orange,
                      greyText: greyText,
                      darkText: darkText,
                      onChanged: (value) {
                        setState(() {
                          distance = value;
                        });
                      },
                    ),

                    const SizedBox(height: 30),

                    // FEATURES
                    FilterSectionTitle(title: "Features", darkText: darkText),

                    const SizedBox(height: 18),

                    FeatureOptions(
                      features: features,
                      selectedFeatures: selectedFeatures,
                      orange: orange,
                      darkText: darkText,
                      lightBorder: lightBorder,
                      onChanged: (feature) {
                        setState(() {
                          if (selectedFeatures.contains(feature)) {
                            selectedFeatures.remove(feature);
                          } else {
                            selectedFeatures.add(feature);
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // APPLY BUTTON
      bottomNavigationBar: ApplyFilterButton(
        orange: orange,
        onPressed: _applyFilters,
      ),
    );
  }

  void _applyFilters() {
    print("Sort: $selectedSort");
    print("Category: $selectedCategory");
    print("Price: $priceRange");
    print("Rating: $selectedRating");
    print("Distance: $distance");
    print("Features: $selectedFeatures");
  }

  void _resetFilters() {
    setState(() {
      selectedSort = "Relevance";
      selectedCategory = "Dogs";
      priceRange = const RangeValues(0, 328);
      selectedRating = "4.5+";
      distance = 5;
      selectedFeatures.clear();
    });
  }
}
