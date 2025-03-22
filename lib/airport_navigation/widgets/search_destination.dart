import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:jet_set_go/packing_tips/style.dart'; // New style import

class SearchDestination extends StatefulWidget {
  final String apiKey;

  const SearchDestination.searchDestination({super.key, required this.apiKey});

  @override
   SearchDestinationState createState() => SearchDestinationState();
}

class SearchDestinationState extends State<SearchDestination> {
  final TextEditingController _controller = TextEditingController();
  List<Prediction> _predictions = [];

  late GoogleMapsPlaces _places;

  @override
  void initState() {
    super.initState();
    _places = GoogleMapsPlaces(apiKey: widget.apiKey);
  }

  // Call the autocomplete API as the user types
  void _searchPlaces(String input) async {
    if (input.isEmpty) {
      setState(() {
        _predictions = [];
      });
      return;
    }
    PlacesAutocompleteResponse response = await _places.autocomplete(input);
    if (response.isOkay) {
      setState(() {
        _predictions = response.predictions;
      });
    } else {
      // Optionally handle error or show a message.
    }
  }

  @override
  Widget build(BuildContext context) {
    return UI(
      title: "SEARCH YOUR",
      subtitle: "DESTINATION",
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height:255),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _predictions.length,
                  itemBuilder: (context, index) {
                    final prediction = _predictions[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.location_on, color: Colors.blueAccent),
                        title: Text(
                          prediction.description ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(prediction);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: 170, // Adjust vertical position
            left: 16,
            right: 16,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.blue[900]),
                    SizedBox(width: 20),

                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Search Destination',
                          border: InputBorder.none,
                        ),
                        onChanged: _searchPlaces,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        _controller.clear();
                        setState(() {
                          _predictions = [];
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}