import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationServiceException implements Exception {
  const LocationServiceException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Wraps [Geolocator] so callers just get a [LatLng] or a clear error.
class LocationService {
  const LocationService();

  /// Live updates only need to fire once the device has moved a few
  /// meters, so battery isn't drained by GPS updates every second.
  static const LocationSettings _liveSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 5,
  );

  Future<void> ensurePermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw const LocationServiceException(
        'Location services are turned off. Please enable them and try again.',
      );
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw const LocationServiceException('Location permission was denied.');
    }
    if (permission == LocationPermission.deniedForever) {
      throw const LocationServiceException(
        'Location permission is permanently denied. Enable it from app settings.',
      );
    }
  }

  Future<LatLng> getCurrentLatLng() async {
    await ensurePermission();
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
    return LatLng(position.latitude, position.longitude);
  }

  /// Emits the device's position as it moves, for real-time tracking on
  /// the map. Callers must call [ensurePermission] first.
  Stream<LatLng> watchLatLng() {
    return Geolocator.getPositionStream(
      locationSettings: _liveSettings,
    ).map((position) => LatLng(position.latitude, position.longitude));
  }
}
