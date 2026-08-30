import 'package:latlong2/latlong.dart';

const _calculator = Distance();

double kmBetween(LatLng a, LatLng b) =>
    _calculator.as(LengthUnit.Kilometer, a, b);
