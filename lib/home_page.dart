import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool isDroneConnected = false; // Tracks drone connection status
  List<String> notifications = []; // Stores notifications

  // Simulate drone connection for demonstration
  void connectDrone() {
    setState(() {
      isDroneConnected = true;
      notifications.add("Drone connected successfully.");
      notifications.add("New detection: Persons or objects identified.");
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
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/sensors');
              break;
            case 2:
              Navigator.pushNamed(context, '/about');
              break;
            case 3:
              Navigator.pushNamed(context, '/account');
              break;
          }
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
            icon: Icon(Icons.person),
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
  final bool isDroneConnected;

  const DroneDetectionPage({required this.isDroneConnected});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isDroneConnected
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/image/drone_image.png',
            height: 200,
            width: 200,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20),
          Text(
            'Live Data from Drone',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      )
          : Text(
        'Drone is not connected.\nPlease connect to view data.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}