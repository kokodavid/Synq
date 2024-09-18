import 'package:supabase_flutter/supabase_flutter.dart';
import '../../agents/models/agent_model.dart';

class AgentService {
  final _supabase = Supabase.instance.client;

  Future<List<Agent>> getAgents() async {
    final response = await _supabase
        .from('agents')
        .select()
        .order('name');
    
    return (response as List).map((json) => Agent.fromJson(json)).toList();
  }

  Future<void> addAgent(Agent agent) async {
    await _supabase.from('agents').insert({
      'name': agent.name,
      'email': agent.email,
      'created_at': agent.createdAt.toIso8601String(),
    });
  }

  Future<void> deleteAgent(String agentId) async {
    await _supabase.from('agents').delete().eq('id', agentId);
  }
}