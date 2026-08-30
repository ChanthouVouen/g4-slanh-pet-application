import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/navigation/bottom_nav_routes.dart';
import 'package:slanh_pet_application/core/widgets/app_search_field.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';
import 'package:slanh_pet_application/features/clinic_detail/clinic_detail.dart';
import 'package:slanh_pet_application/features/map_screen/map_screen.dart';
import 'package:slanh_pet_application/features/services/models/service_model.dart';

import 'widgets/near_you_header.dart';
import 'widgets/clinic_card_card.dart';
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

  late final Future<List<ServiceModel>> _serviceData;

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
  void initState() {
    super.initState();

    _serviceData = getServiceData();
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

            AppSearchField(hintText: 'Search services near you...'),
            const SizedBox(height: 20),

            VetPromoBanner(
              onBookNow: () => _showComingSoon(context, 'Booking coming soon.'),
            ),
            const SizedBox(height: 24),

            NearYouHeader(
              onFilterTap: () =>
                  _showComingSoon(context, 'Filters coming soon.'),
            ),
            const SizedBox(height: 14),

            FutureBuilder<List<ServiceModel>>(
              future: _serviceData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No services found'));
                }

                final services = snapshot.data!;
                if (services.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text('No services available yet.'),
                  );
                }

                return Column(
                  children: [
                    for (final service in services) ...[
                      ClinicCard(
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

  void _onServiceTap(BuildContext context, ServiceModel service) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ClinicDetailsScreen(service: service),
      ),
    );
  }
}
