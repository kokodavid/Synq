import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synq/admin/models/admin_model.dart';

class AdminService {
  final _supabase = Supabase.instance.client;

  Future<List<AdminModel>> getAdmins() async {
    final response = await _supabase
        .from('admins')
        .select()
        .order('name');
    
    return (response as List).map((json) => AdminModel.fromJson(json)).toList();
  }
}