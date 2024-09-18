import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synq/admin/models/user_model.dart';
import 'package:synq/admin/services/users_service.dart';


final userServiceProvider = Provider<UserService>((ref) => UserService());

final usersProvider = FutureProvider<List<UserModel>>((ref) async {
  final userService = ref.read(userServiceProvider);
  return userService.getUsers();
});