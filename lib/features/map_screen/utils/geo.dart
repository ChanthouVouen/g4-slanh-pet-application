import 'package:latlong2/latlong.dart';

const _calculator = Distance();

/// Great-circle distance between [a] and [b], in kilometers.
double kmBetween(LatLng a, LatLng b) =>
    _calculator.as(LengthUnit.Kilometer, a, b);
