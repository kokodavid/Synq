class Location {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String description;
  final String buildingCode;
  final int floorNumber;
  final int capacity;
  final bool isAccessible;

  Location({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.buildingCode,
    required this.floorNumber,
    required this.capacity,
    required this.isAccessible,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['description'],
      buildingCode: json['building_code'],
      floorNumber: json['floor_number'],
      capacity: json['capacity'],
      isAccessible: json['is_accessible'],
    );
  }
}