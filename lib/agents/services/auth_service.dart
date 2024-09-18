import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authServiceProvider = Provider<AuthService>((ref)=> AuthService());

class AuthService {
  final _supabase = Supabase.instance.client;

  bool get isLoggedIn => _supabase.auth.currentUser != null;

  Future<void> signIn(String email, String password)async{
    await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async{
    await _supabase.auth.signOut();
  }
}