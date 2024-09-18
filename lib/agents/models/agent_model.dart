class Agent {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;

  Agent({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
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