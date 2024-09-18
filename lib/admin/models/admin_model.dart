class AdminModel {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;

  AdminModel({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}