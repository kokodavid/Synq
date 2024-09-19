import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final utilsProvider = Provider<Utils>((ref)=> Utils());

class Utils {

  String extractErrorMessage(dynamic error) {
    if (error is AuthException) {
      return error.message;
    } else if (error is PostgrestException) {
      return error.message;
    } else if (error is Exception) {
      return error.toString().split(':').last.trim();
    }
    return 'An unexpected error occured';
  }

}
