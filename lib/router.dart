import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:synq/admin/screens/admin_home_screen.dart';
import 'package:synq/admin/screens/manage_admins.dart';
import 'package:synq/admin/screens/manage_agents.dart';
import 'package:synq/admin/screens/manage_locations.dart';
import 'package:synq/admin/screens/manage_users.dart';
import 'package:synq/agents/screens/agent_homescreen.dart';
import 'package:synq/agents/screens/login_screen.dart';
import 'package:synq/agents/services/auth_service.dart';

final webRouterProvider = Provider<GoRouter>((ref) {
  final authService = ref.watch(authServiceProvider);

  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(isAdminOnly: true),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminHomeScreen(),
      ),
      GoRoute(
        path: '/admin/manage-agents',
        builder: (context, state) => const ManageAgentsScreen(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminHomeScreen(),
      ),
      GoRoute(
        path: '/admin/manage-admins',
        builder: (context, state) => const ManageAdmins(),
      ),
      GoRoute(
        path: '/admin/manage-agents',
        builder: (context, state) => const ManageAgentsScreen(),
      ),
      GoRoute(
        path: '/admin/manage-locations',
        builder: (context, state) => const ManageLocations(),
      ),
      GoRoute(
        path: '/admin/manage-users',
        builder: (context, state) => const ManageUsers(),
      ),
    ],
    redirect: (context, state) async {
      final isLoggedIn = authService.isLoggedIn;
      final isLoggingIn = state.fullPath == '/';

      if (!isLoggedIn && !isLoggingIn) return '/';

      if (isLoggedIn) {
        final userRole = await authService.getUserRole();

        if (userRole == 'admin' || userRole == 'super_admin') {
          if (isLoggingIn) {
            return '/admin';
          }
        } else {
          await authService.signOut();
          return '/';
        }
      }

      return null;
    },
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),
  );
});

final mobileRouteProvider = Provider<GoRouter>((ref) {
  final authService = ref.watch(authServiceProvider);

  return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
        GoRoute(
            path: '/agent',
            builder: (context, state) => const AgentHomeScreen())
      ],
      redirect: (context, state) async {
        final isLoggedIn = authService.isLoggedIn;
        final isLoggingIn = state.path == '/';

        if (!isLoggedIn && !isLoggingIn) return '/';

        if (isLoggedIn) {
          final userRole = await authService.getUserRole();
          if (userRole == 'agent' && state.path != '/agent') {
            return '/agent';
          }
        }

        return null;
      });
});
