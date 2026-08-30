import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import 'package:slanh_pet_application/features/map_screen/models/route_result.dart';

class DirectionsException implements Exception {
  const DirectionsException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Fetches a driving route between two points from the public OSRM API.
class DirectionsService {
  const DirectionsService();

  static const _baseUrl = 'https://router.project-osrm.org/route/v1/driving';
  static const _tableUrl = 'https://router.project-osrm.org/table/v1/driving';

  /// Driving distance in kilometers from [origin] to each of [destinations],
  /// in one request via OSRM's table (distance matrix) service. An entry is
  /// null if no road route could be found to that destination.
  Future<List<double?>> getDrivingDistancesKm({
    required LatLng origin,
    required List<LatLng> destinations,
  }) async {
    if (destinations.isEmpty) return const [];

    final points = [origin, ...destinations];
    final coordinates = points
        .map((point) => '${point.longitude},${point.latitude}')
        .join(';');
    final destinationIndices = List.generate(
      destinations.length,
      (i) => i + 1,
    ).join(';');
    final uri = Uri.parse(
      '$_tableUrl/$coordinates'
      '?sources=0&destinations=$destinationIndices&annotations=distance',
    );

    final http.Response response;
    try {
      response = await http.get(uri);
    } catch (_) {
      throw const DirectionsException(
        'Could not reach the directions service. Check your connection.',
      );
    }

    if (response.statusCode != 200) {
      throw const DirectionsException('Unable to fetch distances right now.');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final rows = body['distances'] as List<dynamic>?;
    final row = (rows == null || rows.isEmpty)
        ? const []
        : rows.first as List<dynamic>;

    return [
      for (final meters in row)
        meters == null ? null : (meters as num) / 1000.0,
    ];
  }

  Future<RouteResult> getRoute({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl/'
      '${origin.longitude},${origin.latitude};'
      '${destination.longitude},${destination.latitude}'
      '?overview=full&geometries=geojson',
    );

    final http.Response response;
    try {
      response = await http.get(uri);
    } catch (_) {
      throw const DirectionsException(
        'Could not reach the directions service. Check your connection.',
      );
    }

    if (response.statusCode != 200) {
      throw const DirectionsException('Unable to fetch directions right now.');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final routes = body['routes'] as List<dynamic>?;
    if (routes == null || routes.isEmpty) {
      throw const DirectionsException('No route was found to that location.');
    }

    final route = routes.first as Map<String, dynamic>;
    final geometry = route['geometry'] as Map<String, dynamic>;
    final coordinates = geometry['coordinates'] as List<dynamic>;

    return RouteResult(
      points: [
        for (final coordinate in coordinates)
          LatLng(
            ((coordinate as List<dynamic>)[1] as num).toDouble(),
            (coordinate[0] as num).toDouble(),
          ),
      ],
      distanceMeters: (route['distance'] as num).toDouble(),
      durationSeconds: (route['duration'] as num).toDouble(),
    );
  }
}
