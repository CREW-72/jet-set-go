import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/airport_edge.dart';
import '../model/airport_node.dart';


class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<AirportNode>> getAirportNodes() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await _db.collection('airport_nodes').get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return AirportNode(
          id: doc.id,
          latitude: data['latitude'],
          longitude: data['longitude'],
          floor: data['floor'],
          name: data['name'],
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<AirportEdge>> getAirportEdges() async {
    // Similar logic for fetching edges
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await _db.collection('airport_edges').get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return AirportEdge(
          sourceNodeId: data['sourceNodeId'],
          destinationNodeId: data['destinationNodeId'],
          cost: (data['cost'] as num).toDouble(), // Ensure double type
        );
      }).toList();
    } catch (e) {
      return [];
    }

  }
}