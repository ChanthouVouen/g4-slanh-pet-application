import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';

import 'package:slanh_pet_application/core/services/map_services/directions_service.dart';
import '../models/service_location.dart';
import '../utils/geo.dart';

/// Looks up real driving distances for the currently visible locations, via
/// OSRM's table (matrix) endpoint — one request for the whole list — so the
/// "X km away" text matches what tapping "Directions" reports.
class RoadDistancesController extends ChangeNotifier {
  RoadDistancesController({DirectionsService? directionsService})
    : _directionsService = directionsService ?? const DirectionsService();

  final DirectionsService _directionsService;

  /// Distance in km, keyed by [ServiceLocation.id]. A missing entry means
  /// the road distance hasn't been fetched (or failed) for that location.
  Map<String, double> distancesKm = const {};

  LatLng? _lastOrigin;
  Set<String>? _lastIds;
  int _requestId = 0;

  /// Re-fetches distances only if the visible location set changed or the
  /// origin moved more than 100m — repeated calls with the same input are
  /// cheap no-ops, so this is safe to call on every rebuild.
  Future<void> refresh({
    required LatLng origin,
    required List<ServiceLocation> locations,
  }) async {
    final ids = locations.map((location) => location.id).toSet();
    final movedFar =
        _lastOrigin == null || kmBetween(_lastOrigin!, origin) >= 0.1;
    if (!movedFar && _lastIds == ids) return;

    _lastOrigin = origin;
    _lastIds = ids;

    final requestId = ++_requestId;
    try {
      final results = await _directionsService.getDrivingDistancesKm(
        origin: origin,
        destinations: [for (final location in locations) location.position],
      );
      if (requestId != _requestId) return; // Superseded by a newer refresh.

      final updated = <String, double>{};
      for (var i = 0; i < locations.length; i++) {
        final km = results[i];
        if (km != null) updated[locations[i].id] = km;
      }
      distancesKm = updated;
      notifyListeners();
    } catch (_) {
      // Keep whatever we had; callers fall back to straight-line distance.
    }
  }
}
