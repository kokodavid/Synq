import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synq/admin/models/location_model.dart';

import '../services/location_service.dart';

final locationServiceProvider = Provider<LocationService>((ref) => LocationService());

final locationsProvider = FutureProvider<List<Location>>((ref) async {
  final locationService = ref.read(locationServiceProvider);
  return locationService.getLocations();
});