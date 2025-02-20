
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
}
