
class AirportNode {
  final String id;
  final double latitude;
  final double longitude;
  final int floor;
  final String name; // e.g., "Gate A1", "Restroom"

  AirportNode({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.floor,
    required this.name,
  });
  // Convert AirportNode to Map for JSON encoding
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'floor': floor,
      'name': name,
    };
  }

  // Factory constructor to create AirportNode from Map
  factory AirportNode.fromJson(Map<String, dynamic> json) {
    return AirportNode(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      floor: json['floor'],
      name: json['name'],
    );
  }
}



