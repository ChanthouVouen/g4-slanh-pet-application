import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' hide Path;

import 'package:slanh_pet_application/core/constants/map_contants/cambodia_map_config.dart';
import 'data/phnom_penh_service_locations.dart';
import 'models/route_result.dart';
import 'models/service_location.dart';
import 'package:slanh_pet_application/core/services/map_services/directions_service.dart';
import 'package:slanh_pet_application/core/services/map_services/location_service.dart';
import 'widgets/current_location_dot.dart';
import 'widgets/map_pin.dart';
import 'widgets/map_search_field.dart';
import 'widgets/osm_attribution.dart';
import 'widgets/osm_tile_layer.dart';
import 'widgets/round_icon_button.dart';
import 'widgets/route_info_bar.dart';
import 'widgets/route_loading_overlay.dart';
import 'widgets/services_sheet.dart';
import 'widgets/show_all_clinics_button.dart';

class ServicesMapScreen extends StatefulWidget {
  const ServicesMapScreen({super.key, this.showClinicsOnly = false});

  /// When true, the screen opens already filtered to clinic locations only.
  final bool showClinicsOnly;

  @override
  State<ServicesMapScreen> createState() => _ServicesMapScreenState();
}

class _ServicesMapScreenState extends State<ServicesMapScreen> {
  final MapController _mapController = MapController();
  final LocationService _locationService = const LocationService();
  final DirectionsService _directionsService = const DirectionsService();

  late bool _showClinicsOnly = widget.showClinicsOnly;
  String _searchQuery = '';
  bool _isRoutingInProgress = false;

  LatLng? _currentPosition;
  RouteResult? _activeRoute;
  ServiceLocation? _routeDestination;

  List<ServiceLocation> get _visibleLocations {
    final query = _searchQuery.trim().toLowerCase();
    final list = phnomPenhServiceLocations.where((location) {
      final matchesFilter = !_showClinicsOnly || location.isClinic;
      final matchesQuery =
          query.isEmpty || location.name.toLowerCase().contains(query);
      return matchesFilter && matchesQuery;
    }).toList();
    list.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    return list;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _fitCameraToVisible(_visibleLocations),
    );
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${location.name} · ${location.distanceKm.toStringAsFixed(1)} km away',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
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
      setState(() {
        _currentPosition = origin;
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
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
                    if (_currentPosition != null)
                      Marker(
                        point: _currentPosition!,
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
                        child: MapPin(
                          location: location,
                          onTap: () => _onLocationTap(location),
                        ),
                      ),
                  ],
                ),
                const OsmAttribution(),
              ],
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                children: [
                  RoundIconButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MapSearchField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                        _fitCameraToVisible(_visibleLocations);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 72, 20, 0),
                child: ShowAllClinicsButton(
                  active: _showClinicsOnly,
                  onTap: () {
                    setState(() {
                      _showClinicsOnly = !_showClinicsOnly;
                    });
                    _fitCameraToVisible(_visibleLocations);
                  },
                ),
              ),
            ),
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
                  showingClinicsOnly: _showClinicsOnly,
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
