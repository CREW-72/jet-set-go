import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import '../model/airport_node.dart';


class DestinationSearch extends StatefulWidget {
  final List<AirportNode> airportNodes; // Pass the list of airport nodes
  final Function(AirportNode) onDestinationSelected;

  DestinationSearch({Key? key, required this.airportNodes, required this.onDestinationSelected}) : super(key: key);

  @override
  _DestinationSearchState createState() => _DestinationSearchState();
}

class _DestinationSearchState extends State<DestinationSearch> {
  final TextEditingController _searchController = TextEditingController();
  List<AirportNode> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchResults = widget.airportNodes;
  }

  void _searchDestinations(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults = widget.airportNodes;
      } else {
        _searchResults = widget.airportNodes
            .where((node) =>
            node.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search Destination',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: _searchDestinations,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final node = _searchResults[index];
                return ListTile(
                  title: Text(node.name),
                  subtitle: Text('Floor ${node.floor}'), // Display floor
                  onTap: () {
                    widget.onDestinationSelected(node);
                    // Optionally close the search UI
                    Navigator.pop(context); // If shown in a dialog/bottom sheet
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}