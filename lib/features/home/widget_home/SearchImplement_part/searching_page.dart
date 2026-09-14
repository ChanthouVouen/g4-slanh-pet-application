import 'package:flutter/material.dart';

import 'package:slanh_pet_application/core/navigation/bottom_nav_routes.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';

// import 'package:slanh_pet_application/features/home/widget_home/search_implement.dart';

class SearchingPage extends StatefulWidget {
  const SearchingPage({super.key});

  static const int _tabIndex = 0;

  @override
  State<SearchingPage> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  final TextEditingController searchController = TextEditingController();

  List<String> recentSearches = [
    "Golden Retriever",
    "Cat food",
    "Dog grooming",
    "Hamster cage",
    "Orn ChanVeasna",
    "Worldwide Handsome",
    "No cap",
  ];

  final List<String> trendingSearches = [
    "🔥 Royal Canin",
    "🐕 Shih Tzu puppy",
    "✂️ Grooming near me",
    "💊 Pet vitamins",
    "🏥 Vet online",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F5),

      body: SafeArea(
        child: Column(
          children: [
            // Search area
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: const Icon(Icons.arrow_back, size: 26),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Search box
                  Expanded(
                    child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F1EF),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          hintText: "Search pets, products, services...",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Page content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // Recent searches
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Recent Searches",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              recentSearches.clear();
                            });
                          },
                          child: const Text(
                            "Clear",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 255, 87, 34),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Recent search chips
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: recentSearches.take(5).map((search) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F1EF),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.history,
                                size: 18,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                search,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 35),

                    // Trending
                    const Text(
                      "Trending",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Trending list
                    Column(
                      children: trendingSearches.map((search) {
                        return Container(
                          height: 67,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Color(0xFFEDE8E5)),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.trending_up,
                                size: 21,
                                color: Colors.grey,
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Text(
                                  search,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              const Icon(
                                Icons.chevron_right,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // Bottom navigation
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: SearchingPage._tabIndex,
        onTap: (index) {
          switchBottomNavTab(
            context,
            currentIndex: SearchingPage._tabIndex,
            index: index,
          );
        },
      ),
    );
  }
}
