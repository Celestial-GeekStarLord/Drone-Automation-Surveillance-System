import 'package:flutter/material.dart';

class SensorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sensor data (can be dynamically fetched)
    final List<Map<String, dynamic>> sensors = [
      {'name': 'GPS', 'status': 'Active'},
      {'name': 'Gas', 'status': 'Active'},
      {'name': 'Temperature', 'status': 'Inactive'},
      {'name': 'Ultrasonic', 'status': 'Active'},
      {'name': 'PIR', 'status': 'Inactive'},
    ];

    // Separate active and inactive sensors
    final activeSensors =
    sensors.where((sensor) => sensor['status'] == 'Active').toList();
    final inactiveSensors =
    sensors.where((sensor) => sensor['status'] == 'Inactive').toList();

    return Scaffold(
      backgroundColor: Color(0xFFAADAE9),
      appBar: AppBar(
        title: const Text('Sensors'),
        backgroundColor: Color(0xFFAADAE9),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo and Title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/image/logo.png',
                  height: 50,
                ),
                const SizedBox(width: 16),
                const Text(
                  'Sensors',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Active Sensors Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Text(
              'Active',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...activeSensors.map((sensor) {
            return SensorTile(name: sensor['name'], status: true);
          }).toList(),

          // Inactive Sensors Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: const Text(
              'Inactive',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...inactiveSensors.map((sensor) {
            return SensorTile(name: sensor['name'], status: false);
          }).toList(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
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
        onTap: (index) {
          // Handle navigation based on the index
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
            // Stay on the current page
              break;
            case 2:
              Navigator.pushNamed(context, '/about');
              break;
            case 3:
              Navigator.pushNamed(context, '/account');
              break;
          }
        },
      ),
    );
  }
}

// Sensor Tile Widget
class SensorTile extends StatelessWidget {
  final String name;
  final bool status; // true = active, false = inactive

  const SensorTile({required this.name, required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: ListTile(
          title: Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Icon(
            Icons.circle,
            color: status ? Colors.green : Colors.red,
            size: 16,
          ),
          onTap: () {
            // Navigate to sensor details
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SensorDetailsPage(sensorName: name),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Sensor Details Page
class SensorDetailsPage extends StatelessWidget {
  final String sensorName;

  const SensorDetailsPage({required this.sensorName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sensorName),
        backgroundColor: Color(0xFFAADAE9),
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Details for $sensorName sensor will be displayed here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
