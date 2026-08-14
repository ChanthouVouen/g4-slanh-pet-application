import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// Map framing so the screen only ever shows Cambodia, focused on Phnom Penh.
class CambodiaMapConfig {
  const CambodiaMapConfig._();

  static const LatLng phnomPenhCenter = LatLng(11.5564, 104.9282);

  static const double initialZoom = 13;
  static const double minZoom = 6;
  static const double maxZoom = 18;

  /// Roughly covers all of Cambodia so the map can't be panned into
  /// neighbouring countries.
  static final LatLngBounds cambodiaBounds = LatLngBounds(
    const LatLng(9.5, 102.0),
    const LatLng(14.8, 108.0),
  );

  static CameraConstraint get cameraConstraint =>
      CameraConstraint.contain(bounds: cambodiaBounds);
}
