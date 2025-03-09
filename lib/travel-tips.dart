import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/travel-tip.dart';

class TravelTipsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Air Travel Tips',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TravelTipsScreen(),
    );
  }
}

class TravelTipsScreen extends StatefulWidget {
  @override
  _TravelTipsScreenState createState() => _TravelTipsScreenState();
}

class _TravelTipsScreenState extends State<TravelTipsScreen> {
  List<TravelTip> travelTipsCategories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTravelTips();
  }

  Future<void> loadTravelTips() async {
    try {
      // Load the JSON file from assets
      final String jsonString = await rootBundle.loadString('assets/data/travel_tips.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      setState(() {
        travelTipsCategories = (jsonData['categories'] as List)
            .map((category) => TravelTip.fromJson(category))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error loading travel tips: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Air Travel Tips'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: travelTipsCategories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TipsDetailScreen(
                    title: travelTipsCategories[index].title,
                    tips: travelTipsCategories[index].tips,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  travelTipsCategories[index].title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TipsDetailScreen extends StatelessWidget {
  final String title;
  final List<String> tips;

  TipsDetailScreen({required this.title, required this.tips});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: tips.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text(tips[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}