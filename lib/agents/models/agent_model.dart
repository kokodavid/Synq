class Agent {
  final String? id;
  final String name;
  final String email;
  final DateTime? createdAt;

  Agent({
    this.id,
    required this.name,
    required this.email,
    this.createdAt,
  });

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
