import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:synq/agents/screens/agent_homescreen.dart';
import 'package:synq/agents/screens/login_screen.dart';
import 'package:synq/agents/services/auth_service.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authService = ref.watch(authServiceProvider);

  return GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
        GoRoute(
            path: '/agent',
            builder: (context, state) => const AgentHomeScreen())
      ],
      redirect: (context, state) {
        // final isLoggedIn = authService.isLoggedIn;
        // final isLoggingIn = state.location == '/';

        //  if (!isLoggedIn && !isLoggingIn) return '/';
        //   if (isLoggedIn && isLoggingIn) return '/agent';

        //   return null;
      });
});
