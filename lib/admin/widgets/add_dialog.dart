import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synq/admin/providers/agent_providers.dart';
import 'package:synq/agents/models/agent_model.dart';
import 'package:synq/helpers/utils/helpers.dart';

final isLoadingProvider = StateProvider.autoDispose<bool>((ref) => false);

final formKeyProvider = Provider.autoDispose((ref) => GlobalKey<FormState>());

final nameControllerProvider = Provider.autoDispose((ref) => TextEditingController());
final emailControllerProvider = Provider.autoDispose((ref) => TextEditingController());

class AddAgentDialog extends ConsumerWidget {
  const AddAgentDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(isLoadingProvider);
    final formKey = ref.watch(formKeyProvider);
    final nameController = ref.watch(nameControllerProvider);
    final emailController = ref.watch(emailControllerProvider);

    return AlertDialog(
      title: const Text('Add New Agent'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              enabled: !isLoading,
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) => value!.isEmpty ? 'Please enter an email' : null,
              enabled: !isLoading,
            ),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: isLoading ? null : () => _addAgent(context, ref),
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text('Add'),
        ),
      ],
    );
  }

  Future<void> _addAgent(BuildContext context, WidgetRef ref) async {
    final formKey = ref.read(formKeyProvider);
    if (formKey.currentState!.validate()) {
      ref.read(isLoadingProvider.notifier).state = true;
      
      final agentService = ref.read(agentServiceProvider);
      final utils = ref.watch(utilsProvider);
      final nameController = ref.read(nameControllerProvider);
      final emailController = ref.read(emailControllerProvider);

      try {
        await agentService.addAgent(
          Agent(
            name: nameController.text,
            email: emailController.text,
          ),
        );
        ref.refresh(agentsProvider);
        
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Agent added successfully'),
          backgroundColor: Colors.green,
        ));
      } catch (e) {
        String errorMessage = utils.extractErrorMessage(e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ));
      } finally {
        ref.read(isLoadingProvider.notifier).state = false;
      }
    }
  }
}
