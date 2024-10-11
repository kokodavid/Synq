import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:synq/agents/services/auth_service.dart';
import 'package:synq/helpers/utils/strings.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final bool isAdminOnly;

  const LoginScreen({super.key, this.isAdminOnly = false});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _handleLogin() async {
    try {
      await ref.read(authServiceProvider).signIn(
            emailController.text,
            passwordController.text,
          );

      final userRole = await ref.read(authServiceProvider).getUserRole();
      log('User role after login: $userRole');

      if (!mounted) return;

      if (widget.isAdminOnly) {
        if (userRole == 'admin' || userRole == 'super_admin') {
          Future.microtask(() => context.go('/admin'));
        } else {
          throw Exception('Only admin users are allowed');
        }
      } else {
        log('Non-admin login, user role: $userRole');
      }
    } catch (e) {
      log('Login error: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      await ref.read(authServiceProvider).signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isAdminOnly ? 'Admin Login' : '')),
      body: !widget.isAdminOnly
          ? Column(
              children: [
                Image.asset(Strings.blackLogo),
                Text(
                  Strings.slogan,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Text(Strings.needAccount),
                
              ],
            )
          : Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _handleLogin,
                      child: Text(widget.isAdminOnly ? 'Admin Login' : 'Login'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}


