import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, User!'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // Notifications Section
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.yellow[100],
            child: Row(
              children: [
                Icon(Icons.warning, color: Colors.orange),
                SizedBox(width: 10),
                Expanded(
                  child: Text('Upcoming trip reminder: Flight at 8 AM!'),
                ),
              ],
            ),
          ),

          // Feature Tiles
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(10),
              children: [
                'Set Up Your Trip',
                'FAQ',
                'App Guide'
              ]
                  .map((feature) => Card(
                elevation: 3,
                child: InkWell(
                  onTap: () {
                    // Handle feature tap
                  },
                  child: Center(
                    child: Text(feature,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16)),
                  ),
                ),
              ))
                  .toList(),
            ),
          ),
        ],
      ),

      // Floating Action Button for Quick Actions
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle quick action
        },
        child: Icon(Icons.help),
        tooltip: 'Request Assistance',
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        backgroundColor: Colors.black,  // Background color of the navbar
        selectedItemColor: Colors.green, // Color of selected item
        unselectedItemColor: Colors.blue, // Color of unselected items
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
