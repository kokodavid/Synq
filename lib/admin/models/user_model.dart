// lib/models/user.dart
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? profilePicture;
  final String? phoneNumber;

  UserModel({required this.id, required this.name, required this.email, this.profilePicture, this.phoneNumber});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profilePicture: json['profile_picture'],
      phoneNumber: json['phone_number'],
    );
  }
}