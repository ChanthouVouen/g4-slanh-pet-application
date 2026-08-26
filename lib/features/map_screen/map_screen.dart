import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:slanh_pet_application/core/constants/map_contants/cambodia_map_config.dart';
import 'package:slanh_pet_application/core/services/map_services/directions_service.dart';
import 'package:slanh_pet_application/core/services/map_services/location_service.dart';
import 'controllers/live_location_controller.dart';
import 'controllers/road_distances_controller.dart';
import 'controllers/service_locations_controller.dart';
import 'models/route_result.dart';
import 'models/service_location.dart';
import 'utils/geo.dart';
import 'widgets/current_location_dot.dart';
import 'widgets/map_pin.dart';
import 'widgets/map_side_controls.dart';
import 'widgets/map_top_bar.dart';
import 'widgets/osm_attribution.dart';
import 'widgets/osm_tile_layer.dart';
import 'widgets/route_info_bar.dart';
import 'widgets/route_loading_overlay.dart';
import 'widgets/services_sheet.dart';

class ServicesMapScreen extends StatefulWidget {
  const ServicesMapScreen({super.key});

  @override
  State<ServicesMapScreen> createState() => _ServicesMapScreenState();
}

class _ServicesMapScreenState extends State<ServicesMapScreen> {
  final MapController _mapController = MapController();
  final LocationService _locationService = const LocationService();
  final DirectionsService _directionsService = const DirectionsService();
  late final LiveLocationController _liveLocation = LiveLocationController(
    locationService: _locationService,
    mapController: _mapController,
  );
  late final ServiceLocationsController _serviceLocations =
      ServiceLocationsController();
  late final RoadDistancesController _roadDistances = RoadDistancesController(
    directionsService: _directionsService,
  );

  String _searchQuery = '';
  bool _isRoutingInProgress = false;

  RouteResult? _activeRoute;
  ServiceLocation? _routeDestination;
  bool _hasFitInitialCamera = false;

  List<ServiceLocation> get _visibleLocations {
    final query = _searchQuery.trim().toLowerCase();
    final origin = _liveLocation.position ?? CambodiaMapConfig.phnomPenhCenter;
    final list = _serviceLocations.locations.where((location) {
      return query.isEmpty || location.name.toLowerCase().contains(query);
    }).toList();
    list.sort(
      (a, b) => kmBetween(
        origin,
        a.position,
      ).compareTo(kmBetween(origin, b.position)),
    );
    return list;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _fitCameraToVisible(_visibleLocations),
    );
    _liveLocation.addListener(_onControllerChanged);
    _liveLocation.start(onError: _showMessage);
    _serviceLocations.addListener(_onServiceLocationsChanged);
    _serviceLocations.start(onError: _showMessage);
    _roadDistances.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    _liveLocation.removeListener(_onControllerChanged);
    _liveLocation.dispose();
    _serviceLocations.removeListener(_onServiceLocationsChanged);
    _serviceLocations.dispose();
    _roadDistances.removeListener(_onControllerChanged);
    _roadDistances.dispose();
    super.dispose();
  }

  void _onControllerChanged() => setState(() {});

  void _onServiceLocationsChanged() {
    setState(() {});
    // The initial post-frame fit runs before Firestore data arrives, so
    // re-fit once the first batch of locations shows up.
    if (!_hasFitInitialCamera && !_serviceLocations.isLoading) {
      _hasFitInitialCamera = true;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _fitCameraToVisible(_visibleLocations),
      );
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _fitCameraToVisible(List<ServiceLocation> visible) {
    if (visible.isEmpty) return;

    if (visible.length == 1) {
      _mapController.move(
        visible.first.position,
        CambodiaMapConfig.initialZoom,
      );
      return;
    }

    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: LatLngBounds.fromPoints([
          for (final location in visible) location.position,
        ]),
        padding: const EdgeInsets.fromLTRB(40, 120, 40, 280),
      ),
    );
  }

  void _onLocationTap(ServiceLocation location) {
    final distanceKm = _distanceKmTo(location);
    final distanceSuffix = distanceKm == null
        ? ''
        : ' · ${distanceKm.toStringAsFixed(1)} km away';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${location.name}$distanceSuffix'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Real driving distance when known, falling back to straight-line
  /// distance while the road distance is still being fetched.
  double? _distanceKmTo(ServiceLocation location) {
    final roadKm = _roadDistances.distancesKm[location.id];
    if (roadKm != null) return roadKm;
    final userPosition = _liveLocation.position;
    return userPosition == null
        ? null
        : kmBetween(userPosition, location.position);
  }

  Future<void> _onGetDirections(ServiceLocation destination) async {
    setState(() => _isRoutingInProgress = true);
    try {
      final origin = await _locationService.getCurrentLatLng();
      final route = await _directionsService.getRoute(
        origin: origin,
        destination: destination.position,
      );

      if (!mounted) return;
      _liveLocation.showPosition(origin);
      setState(() {
        _activeRoute = route;
        _routeDestination = destination;
      });
      _mapController.fitCamera(
        CameraFit.bounds(
          bounds: LatLngBounds.fromPoints([
            origin,
            destination.position,
            ...route.points,
          ]),
          padding: const EdgeInsets.fromLTRB(40, 120, 40, 160),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      _showMessage(error.toString());
    } finally {
      if (mounted) setState(() => _isRoutingInProgress = false);
    }
  }

  void _clearDirections() {
    setState(() {
      _activeRoute = null;
      _routeDestination = null;
    });
    _fitCameraToVisible(_visibleLocations);
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visibleLocations;
    final activeRoute = _activeRoute;
    final userPosition = _liveLocation.position;

    if (userPosition != null && visible.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _roadDistances.refresh(origin: userPosition, locations: visible);
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFEDEEF1),
      body: Stack(
        children: [
          Positioned.fill(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: CambodiaMapConfig.phnomPenhCenter,
                initialZoom: CambodiaMapConfig.initialZoom,
                minZoom: CambodiaMapConfig.minZoom,
                maxZoom: CambodiaMapConfig.maxZoom,
                cameraConstraint: CambodiaMapConfig.cameraConstraint,
                onPositionChanged: (camera, hasGesture) {
                  if (hasGesture) _liveLocation.stopFollowing();
                },
              ),
              children: [
                const OsmTileLayer(),
                if (activeRoute != null)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: activeRoute.points,
                        strokeWidth: 4,
                        color: const Color(0xFF4C6FFF),
                      ),
                    ],
                  ),
                MarkerLayer(
                  markers: [
                    if (_liveLocation.position != null)
                      Marker(
                        point: _liveLocation.position!,
                        width: 35,
                        height: 35,
                        child: const CurrentLocationDot(),
                      ),
                    for (final location in visible)
                      Marker(
                        point: location.position,
                        width: 80,
                        height: 46,
                        alignment: Alignment.topCenter,
                        child: MapPin(onTap: () => _onLocationTap(location)),
                      ),
                  ],
                ),
                const OsmAttribution(),
              ],
            ),
          ),
          MapTopBar(
            onBack: () {
              if (Navigator.of(context).canPop()) Navigator.of(context).pop();
            },
            onSearchChanged: (value) {
              setState(() => _searchQuery = value);
              _fitCameraToVisible(_visibleLocations);
            },
          ),
          MapSideControls(
            isFollowingUser: _liveLocation.isFollowing,
            onRecenter: () =>
                _liveLocation.recenter(CambodiaMapConfig.initialZoom),
          ),
          if (activeRoute != null && _routeDestination != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: RouteInfoBar(
                route: activeRoute,
                destinationName: _routeDestination!.name,
                onClear: _clearDirections,
              ),
            )
          else
            DraggableScrollableSheet(
              initialChildSize: 0.32,
              minChildSize: 0.32,
              maxChildSize: 0.75,
              builder: (context, scrollController) {
                return ServicesSheet(
                  scrollController: scrollController,
                  locations: visible,
                  isLoading: _serviceLocations.isLoading,
                  distanceKmFor: _distanceKmTo,
                  onLocationTap: _onLocationTap,
                  onDirections: _onGetDirections,
                );
              },
            ),
          if (_isRoutingInProgress) const RouteLoadingOverlay(),
        ],
      ),
    );
  }
}
