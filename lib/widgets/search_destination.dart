import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

class SearchPage extends StatefulWidget {
  final String apiKey;

  const SearchPage({Key? key, required this.apiKey}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Location'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search Destination',
                border: OutlineInputBorder(),
              ),
              onChanged: _searchPlaces,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _predictions.length,
              itemBuilder: (context, index) {
                final prediction = _predictions[index];
                return ListTile(
                  title: Text(prediction.description ?? ''),
                  onTap: () {
                    // Return the selected prediction to the previous screen.
                    Navigator.of(context).pop(prediction);
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
