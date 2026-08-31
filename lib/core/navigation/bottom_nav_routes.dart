import 'package:flutter/material.dart';
import 'package:slanh_pet_application/features/home/home_page.dart';
import 'package:slanh_pet_application/features/market_screen/market_screen.dart';
import 'package:slanh_pet_application/features/services/service.dart';

Widget _buildHomeScreen(BuildContext context) => const HomePage();
Widget _buildServiceScreen(BuildContext context) => const ServiceScreen();
Widget _buildMarketScreen(BuildContext context) => const MarketScreen();

/// Screen builder for each bottom navigation tab index.
///
/// Add an entry here once that tab's screen is implemented; tabs missing
/// from this map are simply no-ops when tapped.
const Map<int, WidgetBuilder> kBottomNavScreenBuilders = {
  0: _buildHomeScreen,
  1: _buildMarketScreen,
  2: _buildServiceScreen,
};

/// Switches to the tab at [index] by replacing the current screen.
///
/// Does nothing if [index] is already the active tab, or if no screen has
/// been registered for it yet in [kBottomNavScreenBuilders].
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
