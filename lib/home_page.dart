import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool isDroneConnected = false; // Tracks drone connection status
  List<String> notifications = []; // Stores notifications

  final List<Widget> _pages = [
    DroneDetectionPage(),
    SensorPage(),
    AboutPage(),
    AccountPage(),
  ];

  // Simulate drone connection for demonstration
  void connectDrone() {
    setState(() {
      isDroneConnected = true;
      notifications.add("Drone connected successfully.");
      notifications.add("New detection: Persons objects identified.");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/image/logo.png',
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showNotifications(context);
            },
            icon: Icon(Icons.notifications, color: Colors.black),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/homebg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          _pages[_currentIndex],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sensors),
            label: 'Sensors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: connectDrone, // Simulate drone connection
        child: Icon(Icons.link),
        tooltip: "Simulate Drone Connection",
      ),
    );
  }

  // Show notifications as a modal bottom sheet
  void showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.blue[50],
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Notifications",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Divider(),
              if (isDroneConnected && notifications.isNotEmpty)
                ...notifications.map((notification) => ListTile(
                      title: Text(notification),
                    ))
              else
                Center(
                  child: Text(
                    "No notifications available.",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class DroneDetectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Drone Detection Page',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}

class SensorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Sensor Page',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'About Page',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Account Page',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
