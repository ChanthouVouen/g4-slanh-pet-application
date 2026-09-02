import 'package:flutter/material.dart';
import 'package:slanh_pet_application/features/home/home_page.dart';
import 'package:slanh_pet_application/features/order_booking/order_booking.dart';
import 'package:slanh_pet_application/features/services/service.dart';

Widget _buildHomeScreen(BuildContext context) => const HomePage();
Widget _buildServiceScreen(BuildContext context) => const ServiceScreen();
Widget _buildOrderBookingScreen(BuildContext context) => const OrderBooking();

const Map<int, WidgetBuilder> kBottomNavScreenBuilders = {
  0: _buildHomeScreen,
  2: _buildServiceScreen,
  3: _buildOrderBookingScreen,
};

void switchBottomNavTab(
  BuildContext context, {
  required int currentIndex,
  required int index,
}) {
  if (index == currentIndex) return;

  final builder = kBottomNavScreenBuilders[index];
  if (builder == null) return;

  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: builder));
}
