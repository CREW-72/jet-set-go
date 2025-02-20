class AirportEdge {
  final String sourceNodeId;
  final String destinationNodeId;
  final double cost; // e.g., distance in meters

  AirportEdge({
    required this.sourceNodeId,
    required this.destinationNodeId,
    required this.cost,
  });
}