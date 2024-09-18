import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

class AuthService {
  final _supabase = Supabase.instance.client;

  bool get isLoggedIn => _supabase.auth.currentUser != null;

  Future<void> signIn(String email, String password) async {
    await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  Future<String> getUserRole() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return 'guest';

    try {
      final adminResponse = await _supabase
          .from('admins')
          .select('is_super_admin')
          .eq('user_id', user.id)
          .maybeSingle();

      if (adminResponse != null) {
        return adminResponse['is_super_admin'] == true ? 'super_admin' : 'admin';
      }
    } catch (e) {
      log('Error fetching admin role: $e');
    }

    return 'user'; 
  }
}