import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';

import 'package:slanh_pet_application/core/services/map_services/directions_service.dart';
import '../models/service_location.dart';
import '../utils/geo.dart';

class RoadDistancesController extends ChangeNotifier {
  RoadDistancesController({DirectionsService? directionsService})
    : _directionsService = directionsService ?? const DirectionsService();

  final DirectionsService _directionsService;

  Map<String, double> distancesKm = const {};

  LatLng? _lastOrigin;
  Set<String>? _lastIds;
  int _requestId = 0;

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
      if (requestId != _requestId) return;

      final updated = <String, double>{};
      for (var i = 0; i < locations.length; i++) {
        final km = results[i];
        if (km != null) updated[locations[i].id] = km;
      }
      distancesKm = updated;
      notifyListeners();
    } catch (_) {}
  }
}
