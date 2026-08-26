import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/navigation/bottom_nav_routes.dart';
import 'package:slanh_pet_application/core/widgets/app_search_field.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';
import 'package:slanh_pet_application/features/map_screen/map_screen.dart';

import 'data/service_categories_data.dart';
import 'models/nearby_service.dart';
import 'widgets/near_you_header.dart';
import 'widgets/nearby_service_card.dart';
import 'widgets/service_category_grid.dart';
import 'widgets/services_top_bar.dart';
import 'widgets/vet_promo_banner.dart';
import './data/service_data.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  static const int _tabIndex = 2;

  late final Future<List<NearbyService>> _servicesFuture = getCollectionData()
      .then((services) => services.map(NearbyService.fromMap).toList());

  void _openMapView(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const ServicesMapScreen()));
  }

  void _showComingSoon(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF3EE),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            ServicesTopBar(onMapView: () => _openMapView(context)),
            const SizedBox(height: 16),

            const AppSearchField(hintText: 'Search services near you...'),
            const SizedBox(height: 20),

            VetPromoBanner(
              onBookNow: () => _showComingSoon(context, 'Booking coming soon.'),
            ),
            const SizedBox(height: 24),

            const Text(
              'Service Categories',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 14),

            // ServiceCategoryGrid(
            //   categories: serviceCategories,
            //   onCategoryTap: (category) =>
            //       _showComingSoon(context, '${category.label} coming soon.'),
            // ),
            // const SizedBox(height: 24),
            NearYouHeader(
              onFilterTap: () =>
                  _showComingSoon(context, 'Filters coming soon.'),
            ),
            const SizedBox(height: 14),

            FutureBuilder<List<NearbyService>>(
              future: _servicesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text('Failed to load services: ${snapshot.error}'),
                  );
                }

                final services = snapshot.data ?? const [];

                if (services.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text('No services available yet.'),
                  );
                }

                return Column(
                  children: [
                    for (final service in services) ...[
                      NearbyServiceCard(
                        service: service,
                        onTap: () => _onServiceTap(context, service),
                      ),
                      const SizedBox(height: 14),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _tabIndex,
        onTap: (index) =>
            switchBottomNavTab(context, currentIndex: _tabIndex, index: index),
      ),
    );
  }

  void _onServiceTap(BuildContext context, NearbyService service) {
    _showComingSoon(context, 'Opening ${service.name}...');
  }
}
