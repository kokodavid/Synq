import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:synq/admin/models/admin_model.dart';
import 'package:synq/admin/models/user_model.dart';
import 'package:synq/admin/providers/agent_providers.dart';
import 'package:synq/admin/providers/locations_provider.dart';
import 'package:synq/admin/models/location_model.dart';
import '../../agents/models/agent_model.dart';
import '../providers/admin_providers.dart';
import '../providers/users_provider.dart';

class AdminHomeScreen extends ConsumerWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final admins = ref.watch(adminsProvider);
    final agents = ref.watch(agentsProvider);
    final locations = ref.watch(locationsProvider);
    final users = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // TODO: Implement logout functionality
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildListDelegate([
                _buildAnimatedCard(context, 'Admins', admins, '/admin/manage-admins', Icons.admin_panel_settings, Colors.blue),
                _buildAnimatedCard(context, 'Agents', agents, '/admin/manage-agents', Icons.support_agent, Colors.green),
                _buildAnimatedCard(context, 'Locations', locations, '/admin/manage-locations', Icons.location_on, Colors.orange),
                _buildAnimatedCard(context, 'Users', users, '/admin/manage-users', Icons.people, Colors.purple),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCard(BuildContext context, String title, AsyncValue<List<dynamic>> data, String route, IconData icon, Color color) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: _buildCard(context, title, data, route, icon, color),
    );
  }

  Widget _buildCard(BuildContext context, String title, AsyncValue<List<dynamic>> data, String route, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => GoRouter.of(context).go(route),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, size: 32, color: color),
                  Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
                ],
              ),
            ),
            Expanded(
              child: data.when(
                data: (list) => ListView.builder(
                  itemCount: list.length > 3 ? 3 : list.length,
                  itemBuilder: (context, index) => _buildDetailedListItem(list[index], title, color),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error', style: const TextStyle(color: Colors.red))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () => GoRouter.of(context).go(route),
                child: const Text('View All'),
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildDetailedListItem(dynamic item, String category, Color color) {
    String name = '';
    String? email;

    if (item is AdminModel) {
      name = item.name;
      email = item.email;
    } else if (item is Agent) {
      name = item.name;
      email = item.email;
    } else if (item is Location) {
      name = item.name;
    } else if (item is UserModel) {
      name = item.name;
      email = item.email;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.2),
                child: Text(name.isNotEmpty ? name[0] : '', style: TextStyle(color: color)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
                    if (email != null)
                      Text(email, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildAdditionalInfo(item, category),
          const Divider(),
        ],
      ),
    );
  }

   Widget _buildAdditionalInfo(dynamic item, String category) {
    switch (category) {
      case 'Admins':
        if (item is AdminModel) {
          return Text(
            'Created: ${_formatDate(item.createdAt)}',
            style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          );
        }
        break;
      case 'Agents':
        if (item is Agent) {
          return Text(
            'Created: ${_formatDate(item.createdAt!)}',
            style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          );
        }
        break;
      case 'Locations':
        if (item is Location) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Building: ${item.buildingCode}', style: const TextStyle(fontSize: 12)),
              Text('Floor: ${item.floorNumber}', style: const TextStyle(fontSize: 12)),
              Text('Capacity: ${item.capacity}', style: const TextStyle(fontSize: 12)),
              Text('Accessible: ${item.isAccessible ? 'Yes' : 'No'}', style: const TextStyle(fontSize: 12)),
              Text('Lat: ${item.latitude.toStringAsFixed(4)}', style: const TextStyle(fontSize: 12)),
              Text('Long: ${item.longitude.toStringAsFixed(4)}', style: const TextStyle(fontSize: 12)),
            ],
          );
        }
        break;
      case 'Users':
        if (item is UserModel) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.phoneNumber != null)
                Text('Phone: ${item.phoneNumber}', style: const TextStyle(fontSize: 12)),
              if (item.profilePicture != null)
                const Text('Has Profile Picture', style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
            ],
          );
        }
        break;
    }
    return const SizedBox.shrink();
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }
}