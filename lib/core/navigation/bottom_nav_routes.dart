import 'package:flutter/material.dart';
import 'package:slanh_pet_application/features/home/home_page.dart';
import 'package:slanh_pet_application/features/order_booking/order_booking.dart';
import 'package:slanh_pet_application/features/market_screen/market_screen.dart';
import 'package:slanh_pet_application/features/services/service.dart';
import 'package:slanh_pet_application/features/user_profile/profile.dart';

Widget _buildHomeScreen(BuildContext context) => const HomePage();
Widget _buildServiceScreen(BuildContext context) => const ServiceScreen();
Widget _buildOrderBookingScreen(BuildContext context) => const OrderBooking();
Widget _buildMarketScreen(BuildContext context) => const MarketScreen();
Widget _buildProfileScreen(BuildContext context) => const ProfileScreen();

const Map<int, WidgetBuilder> kBottomNavScreenBuilders = {
  0: _buildHomeScreen,
  1: _buildMarketScreen,
  2: _buildServiceScreen,
  3: _buildOrderBookingScreen,
  4: _buildProfileScreen,
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
