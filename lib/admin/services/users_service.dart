// lib/services/user_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synq/admin/models/user_model.dart';

class UserService {
  final _supabase = Supabase.instance.client;

  Future<List<UserModel>> getUsers() async {
    final response = await _supabase
        .from('users')
        .select()
        .order('name');
    
    return (response as List).map((json) => UserModel.fromJson(json)).toList();
  }
}