import 'package:flutter/material.dart';
import 'package:synq/agents/models/agent_model.dart';

class AgentListTile extends StatelessWidget {
  final Agent agent;
  final VoidCallback onDelete;

  const AgentListTile({Key? key, required this.agent, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text(agent.name[0])),
      title: Text(agent.name),
      subtitle: Text(agent.email),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}