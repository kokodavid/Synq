import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../agents/models/agent_model.dart';
import '../services/agent_service.dart';

final agentServiceProvider = Provider<AgentService>((ref) => AgentService());

final isLoadingProvider = StateProvider.autoDispose<bool>((ref) => false);
final nameController = Provider((ref) => TextEditingController());
final emailController = Provider((ref) => TextEditingController());

final agentsProvider = FutureProvider<List<Agent>>((ref) async {
  final agentService = ref.read(agentServiceProvider);
  return agentService.getAgents();
});

final addAgentsProvider  = FutureProvider.family<void,Agent>((ref,data){
   ref.read(agentServiceProvider).addAgent(data);
});