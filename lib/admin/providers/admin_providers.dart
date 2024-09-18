import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synq/admin/models/admin_model.dart';
import 'package:synq/admin/services/admin_service.dart';


final adminServiceProvider = Provider<AdminService>((ref) => AdminService());

final adminsProvider = FutureProvider<List<AdminModel>>((ref) async {
  final adminService = ref.read(adminServiceProvider);
  return adminService.getAdmins();
});