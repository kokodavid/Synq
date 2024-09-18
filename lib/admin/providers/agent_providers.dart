import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../agents/models/agent_model.dart';
import '../services/agent_service.dart';

final agentServiceProvider = Provider<AgentService>((ref) => AgentService());

final agentsProvider = FutureProvider<List<Agent>>((ref) async {
  final agentService = ref.read(agentServiceProvider);
  return agentService.getAgents();
});