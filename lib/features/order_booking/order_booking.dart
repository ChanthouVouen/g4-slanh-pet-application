import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/navigation/bottom_nav_routes.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';
import 'package:slanh_pet_application/features/order_booking/models/order_item_model.dart';
import 'package:slanh_pet_application/features/order_booking/widgets/order_card.dart';
import 'package:slanh_pet_application/features/order_booking/widgets/order_filter_tabs.dart';
import './data/get_booking.dart';

class OrderBooking extends StatefulWidget {
  const OrderBooking({super.key});

  @override
  State<OrderBooking> createState() => _OrderBookingState();
}

class _OrderBookingState extends State<OrderBooking> {
  static const int _tabIndex = 3;

  static const _filterLabels = ['All', 'Processing', 'Shipped', 'Delivered'];

  int _selectedFilter = 0;
  late final Future<List<OrderItemModel>> _orderData;

  @override
  void initState() {
    super.initState();
    _orderData = getBookingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      appBar: AppBar(
        backgroundColor: AppColors.onboardingBackground,
        elevation: 0,
        title: const Text(
          'My Order & Booking',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: OrderFilterTabs(
                labels: _filterLabels,
                selectedIndex: _selectedFilter,
                onSelected: (index) => setState(() => _selectedFilter = index),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: FutureBuilder<List<OrderItemModel>>(
                future: _orderData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final orders = snapshot.data?.reversed.toList() ?? [];

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    separatorBuilder: (_, _) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      return OrderCard(order: orders[index]);
                    },
                    itemCount: orders.length,
                  );
                },
              ),
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
}
