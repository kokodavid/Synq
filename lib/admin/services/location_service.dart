// lib/services/location_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synq/admin/models/location_model.dart';

class LocationService {
  final _supabase = Supabase.instance.client;

  Future<List<Location>> getLocations() async {
    final response = await _supabase
        .from('campus_locations')
        .select()
        .order('name');
    
    return (response as List).map((json) => Location.fromJson(json)).toList();
  }
}