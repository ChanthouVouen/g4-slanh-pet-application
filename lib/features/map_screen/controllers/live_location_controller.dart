import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:slanh_pet_application/core/services/map_services/location_service.dart';

/// Tracks the device's live position and keeps the map camera centered on
/// it until [stopFollowing] is called (e.g. the user drags the map).
class LiveLocationController extends ChangeNotifier {
  LiveLocationController({
    required this._locationService,
    required this._mapController,
  });

  final LocationService _locationService;
  final MapController _mapController;
  StreamSubscription<LatLng>? _subscription;

  LatLng? position;
  bool isFollowing = true;

  /// Starts listening for position updates. [onError] is called with a
  /// user-facing message if permission is denied or the stream fails.
  Future<void> start({required void Function(String message) onError}) async {
    try {
      await _locationService.ensurePermission();
      _subscription = _locationService.watchLatLng().listen(
        _onPosition,
        onError: (Object error) => onError(error.toString()),
      );
    } on LocationServiceException catch (error) {
      onError(error.toString());
    }
  }

  void _onPosition(LatLng point) {
    position = point;
    if (isFollowing) {
      _mapController.move(point, _mapController.camera.zoom);
    }
    notifyListeners();
  }

  /// Displays [point] as the current position without moving the camera,
  /// e.g. after a one-shot location fetch for directions.
  void showPosition(LatLng point) {
    position = point;
    notifyListeners();
  }

  void stopFollowing() {
    if (!isFollowing) return;
    isFollowing = false;
    notifyListeners();
  }

  void recenter(double zoom) {
    isFollowing = true;
    final point = position;
    if (point != null) {
      _mapController.move(point, zoom);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
