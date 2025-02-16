import 'package:flutter/material.dart';

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

class TravelTipsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> travelTipsCategories = [
    {'title': 'Entering the Airport', 'tips': ['Arrive early', 'Keep ID ready', 'Follow security protocols']},
    {'title': 'Check-in', 'tips': ['Use online check-in', 'Keep boarding pass handy', 'Check baggage allowance']},
    {'title': 'Immigration', 'tips': ['Have visa & passport ready', 'Fill out required forms', 'Follow officer instructions']},
    {'title': 'Waiting for the Plane', 'tips': ['Monitor flight status', 'Charge devices', 'Stay near gate']},
    {'title': 'Lounge Experience', 'tips': ['Use lounge access', 'Enjoy free Wi-Fi', 'Refresh before flight']},
    {'title': 'In-Flight Etiquette', 'tips': ['Keep seat upright', 'Respect fellow passengers', 'Follow cabin crew instructions']},
    {'title': 'Landing at Destination', 'tips': ['Follow deboarding rules', 'Have customs forms ready', 'Claim baggage promptly']},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Air Travel Tips'),
      ),
      body: GridView.builder(
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
                    title: travelTipsCategories[index]['title'],
                    tips: travelTipsCategories[index]['tips'],
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
                  travelTipsCategories[index]['title'],
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
