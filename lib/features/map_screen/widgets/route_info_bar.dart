import 'package:flutter/material.dart';

import '../models/route_result.dart';

/// Bottom card summarizing the active route, with a button to clear it.
class RouteInfoBar extends StatelessWidget {
  const RouteInfoBar({
    super.key,
    required this.route,
    required this.destinationName,
    required this.onClear,
  });

  final RouteResult route;
  final String destinationName;
  final VoidCallback onClear;

  static const Color orange = Color(0xFFFF663C);
  static const Color subtitleGray = Color(0xFF8C97A3);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          elevation: 6,
          shadowColor: Colors.black.withValues(alpha: 0.2),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.directions_rounded, color: orange, size: 26),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Directions to $destinationName',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${route.distanceKm.toStringAsFixed(1)} km · '
                        '${route.durationMinutes} min drive',
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: subtitleGray,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Clear directions',
                  onPressed: onClear,
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
