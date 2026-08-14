import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

/// The OpenStreetMap raster tile layer used as the map's base layer.
class OsmTileLayer extends StatelessWidget {
  const OsmTileLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.example.slanh_pets_app',
    );
  }
}
