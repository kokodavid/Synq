import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synq/admin/providers/agent_providers.dart';
import 'package:synq/agents/models/agent_model.dart';

class DeleteAgentDialog extends ConsumerStatefulWidget {
  final Agent agent;

  const DeleteAgentDialog({super.key, required this.agent});

  @override
  ConsumerState<DeleteAgentDialog> createState() => _DeleteAgentDialogState();
}

class _DeleteAgentDialogState extends ConsumerState<DeleteAgentDialog> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Agent'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Are you sure you want to delete this agent?'),
          const SizedBox(height: 16),
          Text('Name: ${widget.agent.name}', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('Email: ${widget.agent.email}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isDeleting ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isDeleting ? null : _deleteAgent,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: _isDeleting
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text('Delete'),
        ),
      ],
    );
  }

  Future<void> _deleteAgent() async {
   
    
    try {
      final agentService = ref.read(agentServiceProvider);
      await agentService.deleteAgent(widget.agent.id!);
      ref.refresh(agentsProvider);
      
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Agent deleted successfully'),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to delete agent: ${e.toString()}'),
          backgroundColor: Colors.red,
        ));
      }
    } finally {
      
    }
  }
}