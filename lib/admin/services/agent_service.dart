import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../agents/models/agent_model.dart';

class AgentService {
  final _supabase = Supabase.instance.client;

  Future<List<Agent>> getAgents() async {
    final response = await _supabase.from('agents').select().order('name');

    return (response as List).map((json) => Agent.fromJson(json)).toList();
  }

  Future<void> addAgent(Agent agent) async {
    try {
      final authResponse =
          await _supabase.auth.signUp(email: agent.email, password: agent.name);
      if (authResponse.user == null) {
        throw Exception('Failed to create agent account');
      }

      await _supabase.from('agents').insert({
        'user_id': authResponse.user!.id,
        'name': agent.name,
        'email': agent.email,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      log("Error Occured $e");
      if (e is AuthException) {}
      rethrow;
    }
  }

  Future<void> deleteAgent(String agentId) async {
    await _supabase.rpc('begin');

    try {
      final agentResponse = await _supabase
          .from('agents')
          .select('user_id')
          .eq('id', agentId)
          .single();

      final authId = agentResponse['user_id'] as String;

      await _supabase.from('agents').delete().eq('user_id', agentId);

      await _supabase.auth.admin.deleteUser(authId);

      await _supabase.rpc('commit');
    } catch (e) {
      await _supabase.rpc('rollback');
      rethrow;
    }
  }
}
