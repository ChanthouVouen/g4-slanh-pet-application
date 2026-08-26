import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/service_location_repository.dart';
import '../models/service_location.dart';

/// Streams clinic pins from Firestore and exposes the latest list.
class ServiceLocationsController extends ChangeNotifier {
  ServiceLocationsController({ServiceLocationRepository? repository})
    : _repository = repository ?? ServiceLocationRepository();

  final ServiceLocationRepository _repository;
  StreamSubscription<List<ServiceLocation>>? _subscription;

  List<ServiceLocation> locations = const [];
  bool isLoading = true;

  void start({required void Function(String message) onError}) {
    _subscription = _repository.watchAll().listen(
      (value) {
        locations = value;
        isLoading = false;
        notifyListeners();
      },
      onError: (Object error) {
        isLoading = false;
        notifyListeners();
        onError(error.toString());
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
