import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synq/admin/providers/agent_providers.dart';
import 'package:synq/admin/widgets/add_dialog.dart';
import 'package:synq/admin/widgets/agent_list_tile.dart';
import 'package:synq/admin/widgets/delete_agent_dialog.dart';
import 'package:synq/agents/models/agent_model.dart';

class ManageAgentsScreen extends ConsumerWidget {
  const ManageAgentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agents = ref.watch(agentsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Agents'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddAgentDialog(context, ref),
          ),
        ],
      ),
      body: agents.when(
        data: (agentList) => agentList.isEmpty
            ? Center(
                child: Text(
                  'No agents found. Add some!',
                  style: theme.textTheme.titleLarge,
                ),
              )
            : ListView.separated(
                itemCount: agentList.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final agent = agentList[index];
                  return AgentListTile(
                    agent: agent,
                    onDelete: () => _deleteAgent(context, ref, agent),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error', style: TextStyle(color: theme.colorScheme.error)),
        ),
      ),
    );
  }

  void _showAddAgentDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => const AddAgentDialog(),
    );
  }

  void _deleteAgent(BuildContext context, WidgetRef ref, Agent agent) {
    showDialog(
      context: context,
      builder: (context) => DeleteAgentDialog(agent: agent),
    );
  }
}





