import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

/// Required attribution for the OpenStreetMap tile data.
class OsmAttribution extends StatelessWidget {
  const OsmAttribution({super.key});

  @override
  Widget build(BuildContext context) {
    return const RichAttributionWidget(
      attributions: [TextSourceAttribution('OpenStreetMap contributors')],
    );
  }
}
